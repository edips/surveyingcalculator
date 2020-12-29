#include "appsettings.h"

#include <QSettings>
#include <QFileInfo>

AppSettings::AppSettings( QObject *parent ): QObject( parent )
{
  QSettings settings;
  settings.beginGroup( mGroupName );
  QString path = settings.value( "defaultProject", "" ).toString();
  QString layer = settings.value( "defaultLayer/"  + path, "" ).toString();
  bool autoCenter = settings.value( "autoCenter", false ).toBool();
  int gpsTolerance = settings.value( "gpsTolerance", 10 ).toInt();
  int lineRecordingInterval = settings.value( "lineRecordingInterval", 3 ).toInt();

  // Geoclass
  QString xyOrderVal = settings.value( "coord_order", "en" ).toString();
  QString latlongOrderVal = settings.value( "latlong_order", "order_latlong" ).toString();
  int xyDisplayVal = settings.value( "xy_display", 2 ).toInt();
  QString latlongDispVal = settings.value( "latlong_display", "display_dec" ).toString();
  QString latlongFormatVal = settings.value( "latlong_format", "format_notincluded" ).toString();
  bool gridZoneVal = settings.value( "grid_zone", false ).toBool();
  int angleUnitVal = settings.value( "angle_unit", 0 ).toInt();
  int scaleUnitVal = settings.value( "scale_unit", 0 ).toInt();
  int keyboardVal = settings.value( "keyboard", 0 ).toInt();
  int myFontVal = settings.value( "myfont", 5 ).toInt();
  int themeVal = settings.value( "theme", 1 ).toInt();

  settings.endGroup();

  setDefaultProject( path );
  setActiveProject( path );
  setDefaultLayer( layer );
  setAutoCenterMapChecked( autoCenter );
  setGpsAccuracyTolerance( gpsTolerance );
  setLineRecordingInterval( lineRecordingInterval );

  // Geoclass
  setXYOrder( xyOrderVal );
  setLatLongOrder( latlongOrderVal );
  setXyDisplay( xyDisplayVal );
  setLatlongDisplay( latlongDispVal );
  setLatlongFormat( latlongFormatVal );
  setGridZone( gridZoneVal );
  setAngleUnit( angleUnitVal );
  setScaleUnit( scaleUnitVal );
  setKeyboard( keyboardVal );
  setMyFont( myFontVal );
  setTheme( themeVal );
}

QString AppSettings::defaultLayer() const
{
  return mDefaultLayers.value( mActiveProject );
}

void AppSettings::setDefaultLayer( const QString &value )
{
  if ( defaultLayer() != value )
  {
    QSettings settings;
    settings.beginGroup( mGroupName );
    settings.setValue( "defaultLayer/" + mActiveProject, value );
    settings.endGroup();
    mDefaultLayers.insert( mActiveProject, value );
    emit defaultLayerChanged();
  }
}

QString AppSettings::defaultProject() const
{
  return mDefaultProject;
}

void AppSettings::setDefaultProject( const QString &value )
{
  if ( mDefaultProject != value )
  {
    mDefaultProject = value;
    QSettings settings;
    settings.beginGroup( mGroupName );
    settings.setValue( "defaultProject", value );
    settings.endGroup();

    emit defaultProjectChanged();
  }
}

QString AppSettings::activeProject() const
{
  return mActiveProject;
}

void AppSettings::setActiveProject( const QString &value )
{
  if ( mActiveProject != value )
  {
    mActiveProject = value;

    emit activeProjectChanged();
  }
}

bool AppSettings::autoCenterMapChecked()
{
  return mAutoCenterMapChecked;
}


void AppSettings::setAutoCenterMapChecked( bool value )
{

  if ( mAutoCenterMapChecked != value )
  {
    mAutoCenterMapChecked = value;
    QSettings settings;
    settings.beginGroup( mGroupName );
    settings.setValue( "autoCenter", value );
    settings.endGroup();

    emit autoCenterMapCheckedChanged();
  }

}

QString AppSettings::defaultProjectName() const
{
  if ( !mDefaultProject.isEmpty() )
  {
    QFileInfo info( mDefaultProject );
    return info.baseName();
  }
  return QString( "" );
}

int AppSettings::gpsAccuracyTolerance() const
{
  return mGpsAccuracyTolerance;
}

void AppSettings::setGpsAccuracyTolerance( int value )
{
  if ( mGpsAccuracyTolerance != value )
  {
    mGpsAccuracyTolerance = value;
    QSettings settings;
    settings.beginGroup( mGroupName );
    settings.setValue( "gpsTolerance", value );
    settings.endGroup();

    emit gpsAccuracyToleranceChanged();
  }
}

int AppSettings::lineRecordingInterval() const
{
  return mLineRecordingInterval;
}

void AppSettings::setLineRecordingInterval( int value )
{
  if ( mLineRecordingInterval != value )
  {
    mLineRecordingInterval = value;
    QSettings settings;
    settings.beginGroup( mGroupName );
    settings.setValue( "lineRecordingInterval", value );
    settings.endGroup();

    emit lineRecordingIntervalChanged();
  }
}

// Geoclass

// XY order
QString AppSettings::xyOrder() const
{
    return mXyOrder;
}

void AppSettings::setXYOrder(const QString &value)
{
    if ( mXyOrder != value )
    {
      mXyOrder = value;
      QSettings settings;
      settings.beginGroup( mGroupName );
      settings.setValue( "coord_order", value );
      settings.endGroup();

      emit xyOrderChanged();
    }
}

// lat long order
QString AppSettings::latlongOrder() const
{
    return mLatLongOrder;
}

void AppSettings::setLatLongOrder(const QString &value)
{
    if ( mLatLongOrder != value )
    {
      mLatLongOrder = value;
      QSettings settings;
      settings.beginGroup( mGroupName );
      settings.setValue( "latlong_order", value );
      settings.endGroup();

      emit latlongOrderChanged();
    }
}

// XY Display XY YX NE
int AppSettings::xyDisplay() const
{
    return mXyDisplay;
}

void AppSettings::setXyDisplay(int value)
{
    if( mXyDisplay != value )
    {
        mXyDisplay = value;
        QSettings settings;
        settings.beginGroup( mGroupName );
        settings.setValue( "xy_display", value );
        settings.endGroup();

        emit xyDisplayChanged();
    }
}

// Lat long display
QString AppSettings::latlongDisplay() const
{
    return mLatlongDisplay;
}

void AppSettings::setLatlongDisplay(const QString &value)
{
    if( mLatlongDisplay != value )
    {
        mLatlongDisplay = value;
        QSettings settings;
        settings.beginGroup( mGroupName );
        settings.setValue( "latlong_display", value );
        settings.endGroup();

        emit latlongDisplayChanged();
    }
}

QString AppSettings::latlongFormat() const
{
    return mLatLongFormat;
}

void AppSettings::setLatlongFormat(const QString &value)
{
    if( mLatLongFormat != value )
    {
        mLatLongFormat = value;
        QSettings settings;
        settings.beginGroup( mGroupName );
        settings.setValue( "latlong_format", value );
        settings.endGroup();

        emit latlongFormatChanged();
    }
}

// grid zone designator
bool AppSettings::gridZone()
{
    return mGridZone;
}

void AppSettings::setGridZone(const bool value)
{
    if( mGridZone != value )
    {
        mGridZone = value;
        QSettings settings;
        settings.beginGroup( mGroupName );
        settings.setValue("grid_zone", value);
        settings.endGroup();

        emit gridZoneChanged();
    }
}

// Angle unit
int AppSettings::angleUnit() const
{
    return mAngleUnit;
}

void AppSettings::setAngleUnit(int value)
{
    if( mAngleUnit != value )
    {
        mAngleUnit = value;
        QSettings settings;
        settings.beginGroup( mGroupName );
        settings.setValue( "angle_unit", value );
        settings.endGroup();

        emit angleUnitChanged();
    }
}

int AppSettings::scaleUnit() const
{
    return mScaleUnit;
}

void AppSettings::setScaleUnit(int value)
{
    if( mScaleUnit != value )
    {
        mScaleUnit = value;
        QSettings settings;
        settings.beginGroup( mGroupName );
        settings.setValue( "scale_unit", value );
        settings.endGroup();

        emit scaleUnitChanged();
    }
}

// myfont
int AppSettings::myfont() const
{
    return mmyFont;
}

void AppSettings::setMyFont(int value)
{
    if( mmyFont != value )
    {
        mmyFont = value;
        QSettings settings;
        settings.beginGroup( mGroupName );
        settings.setValue( "myfont", value );
        settings.endGroup();

        emit myFontChanged();
    }
}

// keyboard
int AppSettings::keyboard() const
{
    return mKeyboard;
}

void AppSettings::setKeyboard(int value)
{
    if( mKeyboard != value )
    {
        mKeyboard = value;
        QSettings settings;
        settings.beginGroup( mGroupName );
        settings.setValue( "keyboard", value );
        settings.endGroup();

        emit keyboardChanged();
    }
}

// theme
int AppSettings::theme() const
{
    return mTheme;
}

void AppSettings::setTheme(int value)
{
    if( mTheme != value )
    {
        mTheme = value;
        QSettings settings;
        settings.beginGroup( mGroupName );
        settings.setValue( "theme", value );
        settings.endGroup();

        emit themeChanged();
    }
}
