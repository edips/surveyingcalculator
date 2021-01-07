#ifndef APPSETTINGS_H
#define APPSETTINGS_H

#include <QObject>
#include <QHash>

class AppSettings: public QObject
{
    Q_OBJECT
    Q_PROPERTY( QString defaultProject READ defaultProject WRITE setDefaultProject NOTIFY defaultProjectChanged )
    Q_PROPERTY( QString activeProject READ activeProject WRITE setActiveProject NOTIFY activeProjectChanged )
    Q_PROPERTY( QString defaultProjectName READ defaultProjectName NOTIFY defaultProjectChanged )
    Q_PROPERTY( QString defaultLayer READ defaultLayer WRITE setDefaultLayer NOTIFY defaultLayerChanged )
    Q_PROPERTY( bool autoCenterMapChecked READ autoCenterMapChecked WRITE setAutoCenterMapChecked NOTIFY autoCenterMapCheckedChanged )
    Q_PROPERTY( int lineRecordingInterval READ lineRecordingInterval WRITE setLineRecordingInterval NOTIFY lineRecordingIntervalChanged )
    Q_PROPERTY( int gpsAccuracyTolerance READ gpsAccuracyTolerance WRITE setGpsAccuracyTolerance NOTIFY gpsAccuracyToleranceChanged )

    // Geoclass
    Q_PROPERTY( QString xyOrder READ xyOrder WRITE setXYOrder NOTIFY xyOrderChanged )
    Q_PROPERTY( QString latlongOrder READ latlongOrder WRITE setLatLongOrder NOTIFY latlongOrderChanged )
    Q_PROPERTY( int xyDisplay READ xyDisplay WRITE setXyDisplay NOTIFY xyDisplayChanged )
    Q_PROPERTY( QString latlongDisplay READ latlongDisplay WRITE setLatlongDisplay NOTIFY latlongDisplayChanged )
    Q_PROPERTY( QString latlongFormat READ latlongFormat WRITE setLatlongFormat NOTIFY latlongFormatChanged )
    Q_PROPERTY( bool gridZone READ gridZone WRITE setGridZone NOTIFY gridZoneChanged )
    Q_PROPERTY( int angleUnit READ angleUnit WRITE setAngleUnit NOTIFY angleUnitChanged)
    Q_PROPERTY( int scaleUnit READ scaleUnit WRITE setScaleUnit NOTIFY scaleUnitChanged)
    Q_PROPERTY( int keyboard READ keyboard WRITE setKeyboard NOTIFY keyboardChanged )
    Q_PROPERTY( int myfont READ myfont WRITE setMyFont NOTIFY myFontChanged )
    Q_PROPERTY( int theme READ theme WRITE setTheme NOTIFY themeChanged )
    Q_PROPERTY( int lenUnit READ lenUnit WRITE setLenUnit NOTIFY lenUnitChanged )

public:
    explicit AppSettings( QObject *parent = nullptr );

    QString defaultProject() const;
    void setDefaultProject( const QString &value );

    QString defaultProjectName() const;

    QString activeProject() const;
    void setActiveProject( const QString &value );

    QString defaultLayer() const;
    void setDefaultLayer( const QString &value );

    bool autoCenterMapChecked();
    void setAutoCenterMapChecked( const bool value );

    int gpsAccuracyTolerance() const;
    void setGpsAccuracyTolerance( int gpsAccuracyTolerance );

    int lineRecordingInterval() const;
    void setLineRecordingInterval( int lineRecordingInterval );

    // Geoclass
    // XY order
    QString xyOrder() const;
    void setXYOrder( const QString &value );
    // latlong order
    QString latlongOrder() const;
    void setLatLongOrder(const QString &value);
    // XY Display XY NE YX
    int xyDisplay() const;
    void setXyDisplay(int value);
    // latlong display
    QString latlongDisplay() const;
    void setLatlongDisplay( const QString &value );
    // latlong format
    QString latlongFormat() const;
    void setLatlongFormat( const QString &value );
    // grid zone designator
    bool gridZone();
    void setGridZone( const bool value );
    // angle unit
    int angleUnit() const;
    void setAngleUnit(int value);
    // scale unit
    int scaleUnit() const;
    void setScaleUnit( int value );
    // keyboard
    int keyboard() const;
    void setKeyboard( int value );
    // myfont
    int myfont() const;
    void setMyFont( int value );
    // theme
    int theme() const;
    void setTheme( int value );
    // length units
    int lenUnit() const;
    void setLenUnit( int value );

signals:
    void defaultProjectChanged();
    void activeProjectChanged();
    void defaultLayerChanged();
    void autoCenterMapCheckedChanged();
    void gpsAccuracyToleranceChanged();
    void lineRecordingIntervalChanged();

    // Geoclass
    void xyOrderChanged();
    void latlongOrderChanged();
    void xyDisplayChanged();
    void latlongDisplayChanged();
    void latlongFormatChanged();
    void gridZoneChanged();
    void angleUnitChanged();
    void scaleUnitChanged();
    void keyboardChanged();
    void myFontChanged();
    void themeChanged();
    void lenUnitChanged();

private:
    // Projects path
    QString mDefaultProject;
    // Path to active project
    QString mActiveProject;
    // flag for following GPS position
    bool mAutoCenterMapChecked = false;
    // used in GPS signal indicator
    int mGpsAccuracyTolerance = -1;
    // Digitizing period in seconds
    int mLineRecordingInterval = 3;

    // Projects path -> defaultLayer name
    QHash<QString, QString> mDefaultLayers;

    const QString mGroupName = QString( "inputApp" );

    // Geoclass
    // xy order
    QString mXyOrder;
    // lat long order
    QString mLatLongOrder;
    // xy display
    int mXyDisplay;
    // latlong display
    QString mLatlongDisplay;
    // latlon format
    QString mLatLongFormat;
    // grid zone designator
    bool mGridZone;
    // angle unit
    int mAngleUnit;
    // scale unit
    int mScaleUnit;
    // keyboard
    int mKeyboard;
    // myfonts
    int mmyFont;
    // theme
    int mTheme;
    // length unit
    int mLenUnit;
};

#endif // APPSETTINGS_H
