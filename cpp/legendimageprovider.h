#ifndef LEGENDIMAGEPROVIDER_H
#define LEGENDIMAGEPROVIDER_H

#include <QQuickImageProvider>

class QgsLayerTreeModel;
class QgsLayerTree;

class LegendImageProvider : public QQuickImageProvider
{
  public:
    LegendImageProvider( QgsLayerTreeModel *layerTreeRoot );

    QPixmap requestPixmap( const QString &id, QSize *size, const QSize &requestedSize );

  private:
    QgsLayerTreeModel *mLayerTreeModel;
    QgsLayerTree *mRootNode;
};

#endif // LEGENDIMAGEPROVIDER_H
