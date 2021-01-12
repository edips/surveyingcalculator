#define STR1(x)  #x
#define STR(x)  STR1(x)
#include <QtQml>
#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QtDebug>
#include <QQmlError>
#include <QQmlContext>
#include <QQuickWindow>
#include <qqml.h>
#include <qgsmessagelog.h>
#include "cpp/androidutils.h"
#include <QDesktopWidget>
#include "qgsconfig.h"
#include "cpp/inpututils.h"
#include "cpp/projectsmodel.h"
#include "cpp/layersmodel.h"
#include "cpp/digitizingcontroller.h"
#include "cpp/layersproxymodel.h"
#include "cpp/activelayer.h"
#include "cpp/positiondirection.h"

#include "qgsquickutils.h"
#include "qgsproject.h"
#include "qgsproviderregistry.h"

#include "cpp/mapthemesmodel.h"

#ifndef NDEBUG
#include <QQmlDebuggingEnabler>
#endif

#ifdef ANDROID
#include <QCommandLineParser>
#include <qgis.h>
#include <QFile>
#include <QDir>
#include <QtAndroidExtras>
#endif

#include "qgsapplication.h"
#include "cpp/loader.h"
#include "cpp/appsettings.h"
#include "cpp/surveyingutils.h"
#include "cpp/mapprovider.h"

#include <QQmlComponent>
#include <QQmlEngine>
#include <QUrl>
#include <QFontDatabase>
#include <QQuickStyle>




static QString getDataDir()
{
#ifdef QGIS_QUICK_DATA_PATH
    QString dataPathRaw( STR( QGIS_QUICK_DATA_PATH ) );

#ifdef ANDROID
    QFileInfo extDir( "/sdcard/" );
    if ( extDir.isDir() && extDir.isWritable() )
    {
        // seems that this directory transposes to the latter one in case there is no sdcard attached
        dataPathRaw = extDir.path() + "/" + dataPathRaw;
    }
    else
    {
        qDebug() << "extDir: " << extDir.path() << " not writable";

        QStringList split = QDir::homePath().split( "/" ); // something like /data/user/0/uk.co.lutraconsulting/files
        // TODO support active user from QDir::homePath()
        QFileInfo usrDir( "/storage/emulated/" + split[2] + "/" );
        dataPathRaw = usrDir.path() + "/" + dataPathRaw;
        if ( !( usrDir.isDir() && usrDir.isWritable() ) )
        {
            qDebug() << "usrDir: " << usrDir.path() << " not writable";
        }
    }
#endif

    qputenv( "QGIS_QUICK_DATA_PATH", dataPathRaw.toUtf8().constData() );
#else
    qDebug( "== Must set QGIS_QUICK_DATA_PATH in order to get QGIS Quick running! ==" );
#endif
    QString dataDir = QString::fromLocal8Bit( qgetenv( "QGIS_QUICK_DATA_PATH" ) ) ;
    qDebug() << "QGIS_QUICK_DATA_PATH: " << dataDir;
    return dataDir;
}

static void setEnvironmentQgisPrefixPath()
{
#ifdef DESKTOP_OS
#ifdef QGIS_PREFIX_PATH
    // it is very important to set Prefix path, elsewhere we will get QgsQuick not installed error
    qputenv( "QGIS_PREFIX_PATH", STR( QGIS_PREFIX_PATH ) );
#endif
    if ( QString::fromLocal8Bit( qgetenv( "QGIS_PREFIX_PATH" ) ).isEmpty() )
    {
        // if not on Android, QGIS_PREFIX_PATH env variable should have been set already or defined as C++ define
        qDebug( "== Must set QGIS_PREFIX_PATH in order to get QGIS Quick module running! ==" );
    }
#endif

#if defined (ANDROID) || defined (Q_OS_IOS)
    QDir myDir( QDir::homePath() );
    myDir.cdUp();
    QString prefixPath = myDir.absolutePath();  // something like: /data/data/org.qgis.quick
    qputenv( "QGIS_PREFIX_PATH", prefixPath.toUtf8().constData() );
#elif defined (Q_OS_WIN32)
    QString prefixPath = QCoreApplication::applicationDirPath();
    qputenv( "QGIS_PREFIX_PATH", prefixPath.toUtf8().constData() );
#endif

    qDebug() << "QGIS_PREFIX_PATH: " << QString::fromLocal8Bit( qgetenv( "QGIS_PREFIX_PATH" ) );
}

static void init_qgis( const QString &pkgPath )
{
    QgsApplication::init();

#ifdef MOBILE_OS
    // QGIS plugins on Android are in the same path as other libraries
    QgsApplication::setPluginPath( QApplication::applicationDirPath() );
    QgsApplication::setPkgDataPath( pkgPath );
#else
    Q_UNUSED( pkgPath )
#endif

    QgsApplication::initQgis();

    // make sure the DB exists - otherwise custom projections will be failing
    if ( !QgsApplication::createDatabase() )
        qDebug( "Can't create qgis user DB!!!" );

    qDebug( "qgis providers:\n%s", QgsProviderRegistry::instance()->pluginList().toLatin1().data() );
}

static void init_proj( const QString &pkgPath )
{
#ifdef MOBILE_OS
#ifdef ANDROID
    // win and ios resources are already in the bundle
    InputUtils::cpDir( "assets:/qgis-data", pkgPath );
    QString prefixPath = pkgPath + "/proj";
    QString projFilePath = prefixPath + "/proj.db";
#endif

#ifdef Q_OS_IOS
    QString prefixPath = pkgPath + "/proj";
    QString projFilePath = prefixPath + "/proj.db";
#endif

#ifdef Q_OS_WIN32
    QString prefixPath = pkgPath + "\\proj";
    QString projFilePath = prefixPath + "\\proj.db";
#endif

    qDebug( "PROJ6 resources: %s", prefixPath.toLatin1().data() );
    QFile projdb( projFilePath );
    if ( projdb.exists() )
    {
        qputenv( "PROJ_LIB", prefixPath.toUtf8().constData() );
    }
    else
    {
        InputUtils::log( QStringLiteral( "PROJ6 error" ), QStringLiteral( "The Input has failed to load PROJ6 database." ) );
    }

#else
    // proj share lib is set from the proj installation on the desktop,
    // so it should work without any modifications.
    // to test check QgsProjUtils.searchPaths() in QGIS Python Console
    Q_UNUSED( pkgPath )
#endif

}

void initDeclarative()
{
    qmlRegisterUncreatableType<ProjectModel>( "lc", 1, 0, "ProjectModel", "" );
    qmlRegisterUncreatableType<LayersModel>( "lc", 1, 0, "LayersModel", "" );
    qmlRegisterUncreatableType<MapThemesModel>( "lc", 1, 0, "MapThemesModel", "" );
    qmlRegisterUncreatableType<Loader>( "lc", 1, 0, "Loader", "" );
    qmlRegisterUncreatableType<AppSettings>( "lc", 1, 0, "AppSettings", "" );
    qmlRegisterType<DigitizingController>( "lc", 1, 0, "DigitizingController" );
    qmlRegisterType<SurveyingUtils>( "lc", 1, 0, "SurveyingUtils" );
    qmlRegisterUncreatableType<LayersProxyModel>( "lc", 1, 0, "LayersProxyModel", "" );
    qmlRegisterUncreatableType<ActiveLayer>( "lc", 1, 0, "ActiveLayer", "" );
    qmlRegisterType<PositionDirection>( "lc", 1, 0, "PositionDirection" );
}

void addQmlImportPath( QQmlEngine &engine )
{
    // This adds a runtime qml directory containing QgsQuick plugin
    // when Input is installed (e.g. Android/Win32)
    engine.addImportPath( QgsApplication::qmlImportPath() );
    qDebug() << "adding QML import Path: " << QgsApplication::qmlImportPath();

#ifdef QML_BUILD_IMPORT_DIR
    // Adds a runtime qml directory containing QgsQuick plugin
    // if we are using the developer mode (not installed Input)
    // e.g. Linux/MacOS
    QString qmlBuildImportPath( STR( QML_BUILD_IMPORT_DIR ) );
    engine.addImportPath( qmlBuildImportPath );
    qDebug() << "adding QML import Path: " << qmlBuildImportPath;
#endif

#ifdef Q_OS_IOS
    // REQUIRED FOR IOS - to load QgsQuick/*.qml files defined in qmldir
    engine.addImportPath( "qrc:///" );
    qDebug() << "adding QML import Path: " << "qrc:///";
#endif
}

// sqlite data path for android
QString appdir()
{
    QStringList dirs = QStandardPaths::standardLocations(QStandardPaths::AppDataLocation);
    if (dirs.length() >= 2)
        return dirs[1];
    if (dirs.length() == 1)
        return dirs[0];
    return "";
}

// function to copy sqlite coordinate database
static bool cpDir( const QString &srcPath, const QString &dstPath )
{
    QDir parentDstDir( QFileInfo( dstPath ).path() );
    if ( !parentDstDir.mkpath( dstPath ) )
        return false;

    QDir srcDir( srcPath );
    foreach ( const QFileInfo &info, srcDir.entryInfoList( QDir::Dirs | QDir::Files | QDir::NoDotAndDotDot ) )
    {
        QString srcItemPath = srcPath + "/" + info.fileName();
        QString dstItemPath = dstPath + "/" + info.fileName();
        if ( info.isDir() )
        {
            if ( !cpDir( srcItemPath, dstItemPath ) )
            {
                qDebug() << "Cannot copy dir " << srcItemPath << " > " << dstItemPath;
                return false;
            }
        }
        else if ( info.isFile() )
        {
            if ( !QFile::copy( srcItemPath, dstItemPath ) )
            {
                qDebug() << "Cannot copy file " << srcItemPath << " > " << dstItemPath;
                return false;
            }
            QFile::setPermissions( dstItemPath, QFile::ReadUser | QFile::WriteUser | QFile::ReadOwner | QFile::WriteOwner );
        }
        else
        {
            qDebug() << "Unhandled item" << info.filePath() << "in cpDir";
        }
    }
    return true;
}
// copy sqlite coordinate database
static void copy_sqlite( const QString &sqliteDir )
{
#ifdef ANDROID
    QString assetsBasePath( "assets:" );
    qDebug( "assets base path for sqlite:  %s", assetsBasePath.toLatin1().data() );
    cpDir( assetsBasePath + "/qml/OfflineStorage/Databases", sqliteDir );
    /*#else
  Q_UNUSED( projectDir );*/
#endif
}

quint64 dir_size(const QString & str)
{
    quint64 sizex = 0;
    QFileInfo str_info(str);
    if (str_info.isDir())
    {
        QDir dir(str);
        QFileInfoList list = dir.entryInfoList(QDir::Files | QDir::Dirs |  QDir::Hidden | QDir::NoSymLinks | QDir::NoDotAndDotDot);
        for (int i = 0; i < list.size(); ++i)
        {
            QFileInfo fileInfo = list.at(i);
            if(fileInfo.isDir())
            {
                    sizex += dir_size(fileInfo.absoluteFilePath());
            }
            else
                sizex += fileInfo.size();

        }
    }
    return sizex;
}

void clearDir( const QString path )
{
    QDir dir( path );

    dir.setFilter( QDir::NoDotAndDotDot | QDir::Files );
    foreach( QString dirItem, dir.entryList() )
        dir.remove( dirItem );

    dir.setFilter( QDir::NoDotAndDotDot | QDir::Dirs );
    foreach( QString dirItem, dir.entryList() )
    {
        QDir subDir( dir.absoluteFilePath( dirItem ) );
        subDir.removeRecursively();
        qDebug() << dir.entryList().length();
    }
}

// main cpp
int main(int argc, char *argv[])
{
    // if size of cache or app data is more than 10 MB, set it to zero
    int cache_size = dir_size( QStandardPaths::writableLocation( QStandardPaths::CacheLocation ) );
    int data_size = dir_size( QStandardPaths::writableLocation( QStandardPaths::AppDataLocation ) );

    if( data_size > 10000000 ) {
        qputenv("QML_DISABLE_DISK_CACHE", "true");
    }

    if( cache_size > 10000000 ) {
        QString path = QStandardPaths::writableLocation( QStandardPaths::CacheLocation );
        clearDir( path );
    }

    // High DPI
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QQuickStyle::setStyle("Universal");

    QgsApplication app( argc, argv, true );

    QQmlEngine engine;

    // Description of the app for making settings work in QML
    QCoreApplication::setOrganizationName("Geosoft");
    QCoreApplication::setOrganizationDomain("surveyingcalculator.org");
    QCoreApplication::setApplicationName("Surveying Calculator");
    QCoreApplication::setApplicationVersion( "3.1" );

    qDebug() << "Built with QGIS version " << VERSION_INT;
    // Add fonts to fontDatabase
    QFontDatabase::addApplicationFont(":/assets/fonts/Lato-Regular.ttf");
    QFontDatabase::addApplicationFont(":/assets/fonts/Lato-Bold.ttf");

    // Require permissions before accessing data folder
#ifdef ANDROID
    AndroidUtils::requirePermissions();
#endif

    // Set/Get enviroment
    QString dataDir = getDataDir( );
    QString projectDir = dataDir + "/projects";
    InputUtils::setLogFilename( projectDir + "/.logs" );
    setEnvironmentQgisPrefixPath();

    QString appBundleDir;
#ifdef ANDROID
    appBundleDir = dataDir + "/qgis-data";
#endif

    init_proj( appBundleDir );
    init_qgis( appBundleDir );

    // Create classes
    AndroidUtils au;
    LocalProjectsManager localProjects( projectDir );
    ProjectModel pm( localProjects );
    MapThemesModel mtm;
    AppSettings as;
    InputUtils iu;
    LayersModel lm;
    LayersProxyModel browseLpm( &lm, ModelTypes::BrowseDataLayerSelection );
    LayersProxyModel recordingLpm( &lm, ModelTypes::ActiveLayerSelection );
    ActiveLayer al;
    Loader loader( mtm, as, al );
    //std::unique_ptr<VariablesManager> vm( new VariablesManager( ma.get() ) );

    SurveyingUtils surv;


    // Connections
    QObject::connect( &app, &QGuiApplication::applicationStateChanged, &loader, &Loader::appStateChanged );
    //QObject::connect( &app, &QCoreApplication::aboutToQuit, &loader, &Loader::appAboutToQuit );
    //QObject::connect( &mtm, &MapThemesModel::mapThemeChanged, &recordingLpm, &LayersProxyModel::onMapThemeChanged );
    //QObject::connect( &loader, &Loader::projectReloaded, vm.get(), &VariablesManager::merginProjectChanged );
    /*QObject::connect( QgsApplication::messageLog(),
                      static_cast<void ( QgsMessageLog::* )( const QString &message, const QString &tag, Qgis::MessageLevel level )>( &QgsMessageLog::messageReceived ),
                      &iu,
                      &InputUtils::onQgsLogMessageReceived );*/




    QFile projectLoadingFile( Loader::LOADING_FLAG_FILE_PATH );
    if ( projectLoadingFile.exists() )
    {
        // Cleaning default project due to a project loading has crashed during the last run.
        as.setDefaultProject( QString() );
        projectLoadingFile.remove();
        InputUtils::log( QStringLiteral( "Loading project error" ), QStringLiteral( "The Input has been unexpectedly finished during the last run." ) );
    }

    engine.addImportPath( QgsApplication::qmlImportPath() );
    initDeclarative();

    // QGIS environment variables to set
    // OGR_SQLITE_JOURNAL is set to DELETE to avoid working with WAL files
    // and properly close connection after writting changes to gpkg.
    ::setenv( "OGR_SQLITE_JOURNAL", "DELETE", 1 );

    // Register to QQmlEngine
    engine.rootContext()->setContextProperty( "__androidUtils", &au );
    engine.rootContext()->setContextProperty( "__inputUtils", &iu );
    engine.rootContext()->setContextProperty( "__projectsModel", &pm );
    engine.rootContext()->setContextProperty( "__loader", &loader );
    engine.rootContext()->setContextProperty( "__layersModel", &lm );
    engine.rootContext()->setContextProperty( "__appSettings", &as );
    engine.rootContext()->setContextProperty( "__mapThemesModel", &mtm );
    engine.rootContext()->setContextProperty("__surveyingUtils", &surv );


    engine.rootContext()->setContextProperty( "__recordingLayersModel", &recordingLpm );
    engine.rootContext()->setContextProperty( "__browseDataLayersModel", &browseLpm );
    engine.rootContext()->setContextProperty( "__activeLayer", &al );
    // For UTM Map mapprovider
    mapProvider* provider = new mapProvider();
    engine.rootContext()->setContextProperty("provider", provider);


#ifdef ANDROID
    engine.rootContext()->setContextProperty( "__appwindowvisibility", "Maximized" );
#else
    engine.rootContext()->setContextProperty( "__appwindowvisibility", "windowed" );
#endif
    // Set simulated position for desktop builds
#ifndef ANDROID
    bool use_simulated_position = true;
#else
    bool use_simulated_position = false;
#endif
    engine.rootContext()->setContextProperty( "__use_simulated_position", use_simulated_position );


    // Copying Storage SQLite database
    qDebug() << "Default storage path >> "+engine.offlineStoragePath();
    QString localPath = QStandardPaths::writableLocation( QStandardPaths::AppDataLocation );
    QString dbpath = appdir() + "/OfflineStorage/Databases/e04d88072f90f86a07481418b8ff4b6b.sqlite";
    QString offline_path = appdir() + "/OfflineStorage";
    engine.setOfflineStoragePath(QString(offline_path));
    qDebug() << "New storage path >> "+engine.offlineStoragePath();

    // remove database folder before copying
    QDir dir(engine.offlineStoragePath());
    dir.removeRecursively();

    // copy sqlite database
    copy_sqlite(engine.offlineStoragePath()+"/Databases");
    // end of copy process of SQLite database

    //newly added from Map View to load main.qml
    QQmlComponent component( &engine, QUrl( QStringLiteral("qrc:///qml/main.qml")) );
    QObject *object = component.create();

    if ( !component.errors().isEmpty() )
    {
        qDebug( "%s", QgsApplication::showSettings().toLocal8Bit().data() );

        qDebug() << "****************************************";
        qDebug() << "*****        QML errors:           *****";
        qDebug() << "****************************************";
        for ( const QQmlError &error : component.errors() )
        {
            qDebug() << "  " << error;
        }
        qDebug() << "****************************************";
        qDebug() << "****************************************";
    }

    if ( object == nullptr )
    {
        qDebug() << "FATAL ERROR: unable to create main.qml";
        return EXIT_FAILURE;
    }
    // end of map view code


#ifndef ANDROID
    QCommandLineParser parser;
    parser.addVersionOption();
    parser.process( app );
#endif

    // Add some data for debugging if needed
    QgsApplication::messageLog()->logMessage( QgsQuickUtils().dumpScreenInfo() );
    QgsApplication::messageLog()->logMessage( "data directory: " + dataDir );
    QgsApplication::messageLog()->logMessage( "All up and running" );

    return app.exec();
}
