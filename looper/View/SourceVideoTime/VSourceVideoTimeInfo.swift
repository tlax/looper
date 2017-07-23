import UIKit

class VSourceVideoTimeInfo:VCollection<
    VSourceVideoTime,
    MSourceVideoTime,
    CSourceVideoTime,
    VSourceVideoTimeInfoCell>
{
    private let kMarginTop:CGFloat = 10
    private let kInterItem:CGFloat = 3
    private let kCellHeight:CGFloat = 35
    
    required init(controller:CSourceVideoTime)
    {
        super.init(controller:controller)
        collectionView.alwaysBounceVertical = true
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.minimumLineSpacing = kInterItem
            flow.sectionInset = UIEdgeInsets(
                top:VSourceVideoTime.kBarMaxHeight + kMarginTop,
                left:0,
                bottom:VSourceVideoTime.kBottomBarHeight,
                right:0)
        }
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        layout collectionViewLayout:UICollectionViewLayout,
        sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let width:CGFloat = collectionView.bounds.width
        let size:CGSize = CGSize(width:width, height:kCellHeight)
        
        return size
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model.items.count
        
        return count
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MSourceVideoTimeItemProtocol = modelAtIndex(index:indexPath)
        let cell:VSourceVideoTimeInfoCell = cellAtIndex(
            indexPath:indexPath)
        cell.config(model:item)
        
        return cell
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MSourceVideoTimeItemProtocol
    {
        let item:MSourceVideoTimeItemProtocol = controller.model.items[index.item]
        
        return item
    }
}
