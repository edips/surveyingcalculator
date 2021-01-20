/***************************************************************************
  Copyright            : (C)  Lutra Consulting
  Modified by          : Edip Ahmet Taşkın
  Email                : geosoft66@gmail.com
 ***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

#ifndef ANDROIDUTILS_H
#define ANDROIDUTILS_H


#ifdef ANDROID
#include <QAndroidActivityResultReceiver>
#include <QAndroidJniObject>
#endif
#include <QObject>

class AndroidUtils: public QObject
#ifdef ANDROID
  , QAndroidActivityResultReceiver
#endif
{
    Q_OBJECT
    // to know OS is Android or not on QML
    Q_PROPERTY( bool isAndroid READ isAndroid CONSTANT )

  public:
    explicit AndroidUtils( QObject *parent = nullptr );

    bool isAndroid() const;
    // require permissions on main.cpp
    static void requirePermissions();
    static bool checkAndAcquirePermissions( const QString &permissionString );

    /**
      * Starts ACTION_PICK activity which opens a gallery. If an image is selected,
      * handler of the activity emits imageSelected signal.
      * */
    Q_INVOKABLE void callImagePicker();
    Q_INVOKABLE void callCamera( const QString &targetPath );
#ifdef ANDROID
    const static int MEDIA_CODE = 101;
    const static int CAMERA_CODE = 102;

    void handleActivityResult( int receiverRequestCode, int resultCode, const QAndroidJniObject &data ) override;
#endif

  signals:
    void imageSelected( QString imagePath );

  public slots:
    void showToast( QString message );

  private:
    bool mIsAndroid;

};

#endif // ANDROIDUTILS_H
