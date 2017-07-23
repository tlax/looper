import UIKit

class VSourceVideoTimeInfo:VCollection<
    VSourceVideoTime,
    MSourceVideoTime,
    CSourceVideoTime,
    VSourceVideoTimeInfoCell>
{
    private let kMarginTop:CGFloat = 10
    private let kInterItem:CGFloat = 2
    private let kCellHeight:CGFloat = 30
    private let kFooterHeight:CGFloat = 100
    
    required init(controller:CSourceVideoTime)
    {
        super.init(controller:controller)
        collectionView.alwaysBounceVertical = true
        registerFooter(footer:VSourceVideoTimeInfoFooter.self)
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.minimumLineSpacing = kInterItem
            flow.footerReferenceSize = CGSize(
                width:0,
                height:kFooterHeight + VSourceVideoTime.kBottomBarHeight)
            flow.sectionInset = UIEdgeInsets(
                top:VSourceVideoTime.kBarMaxHeight + kMarginTop,
                left:0,
                bottom:0,
                right:0)
        }
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func scrollViewDidScroll(
        _ scrollView:UIScrollView)
    {
        guard
        
            let view:VSourceVideoTime = controller.view as? VSourceVideoTime
        
        else
        {
            return
        }
        
        let offsetY:CGFloat = scrollView.contentOffset.y
        var newHeight:CGFloat = VSourceVideoTime.kBarMaxHeight - offsetY
        
        if newHeight < 0
        {
            newHeight = 0
        }
        
        view.layoutBarHeight.constant = newHeight
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
        viewForSupplementaryElementOfKind kind:String,
        at indexPath:IndexPath) -> UICollectionReusableView
    {
        let reusable:VSourceVideoTimeInfoFooter = reusableAtIndex(
            kind:kind,
            type:VSourceVideoTimeInfoFooter.self,
            indexPath:indexPath)
        
        return reusable
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
    
    override func collectionView(
        _ collectionView:UICollectionView,
        shouldSelectItemAt indexPath:IndexPath) -> Bool
    {
        return false
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        shouldHighlightItemAt indexPath:IndexPath) -> Bool
    {
        return false
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MSourceVideoTimeItemProtocol
    {
        let item:MSourceVideoTimeItemProtocol = controller.model.items[index.item]
        
        return item
    }
}
