#include "legendimageprovider.h"

#include <qgsproject.h>
#include <qgslayertree.h>
#include <qgslayertreelayer.h>
#include <qgslayertreemodel.h>
#include <qgslayertreemodellegendnode.h>

LegendImageProvider::LegendImageProvider( QgsLayerTreeModel *layerTreeModel )
  : QQuickImageProvider( Pixmap )
  , mLayerTreeModel( layerTreeModel )
  , mRootNode( layerTreeModel->rootGroup() )
{

}

QPixmap LegendImageProvider::requestPixmap( const QString &id, QSize *size, const QSize &requestedSize )
{
  Q_UNUSED( size )
  QStringList idParts = id.split( '/' );

  if ( idParts.value( 0 ) == QStringLiteral( "legend" ) )
  {
    QgsLayerTreeLayer *layerNode = mRootNode->findLayer( idParts.value( 1 ) );
    QModelIndex layerIndex = mLayerTreeModel->node2index( layerNode );
    int legendCount = mLayerTreeModel->rowCount( layerIndex );
    for ( int i = 0; i < legendCount; ++i )
    {
      QModelIndex legendIndex = mLayerTreeModel->index( i, 0, layerIndex );
      if ( idParts.value( 2 ) == mLayerTreeModel->data( legendIndex ) )
        return mLayerTreeModel->data( legendIndex, Qt::DecorationRole ).value<QPixmap>();
    }
  }
  if ( idParts.value( 0 ) == QStringLiteral( "layer" ) )
  {
    QgsLayerTreeLayer *layerNode = mRootNode->findLayer( idParts.value( 1 ) );

    if ( layerNode )
    {
      QgsLayerTreeModelLegendNode *legendNode = mLayerTreeModel->legendNodeEmbeddedInParent( layerNode );
      if ( legendNode )
        return legendNode->data( Qt::DecorationRole ).value<QPixmap>();
    }
  }

  return QPixmap( requestedSize );
}
