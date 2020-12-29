#include <QQmlEngine>
#ifdef QTAT_APP_PERMISSIONS
#include "QAndroidAppPermissions.h"
#endif
#include "QtAndroidTools.h"

QtAndroidTools::QtAndroidTools()
{
}

void QtAndroidTools::InitializeQmlTools()
{
#ifdef QTAT_APP_PERMISSIONS
    qmlRegisterSingletonType<QAndroidAppPermissions>("QtAndroidTools", 1, 0, "QtAndroidAppPermissions", &QAndroidAppPermissions::qmlInstance);
#endif

}
