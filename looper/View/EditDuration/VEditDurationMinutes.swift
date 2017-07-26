import UIKit

class VEditDurationMinutes:VCollection<
    VEditDuration,
    MEditDuration,
    CEditDuration,
    VEditDurationCell>
{
    private var cellSize:CGSize?
    private var trackScroll:Bool
    private let kCellWidth:CGFloat = 40
    
    required init(controller:CEditDuration)
    {
        trackScroll = true
        
        super.init(controller:controller)
        collectionView.alwaysBounceHorizontal = true
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        }
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        layout collectionViewLayout:UICollectionViewLayout,
        insetForSectionAt section:Int) -> UIEdgeInsets
    {
        let width:CGFloat = collectionView.bounds.width
        let width_2:CGFloat = width / 2.0
        let cellWidth_2:CGFloat = kCellWidth / 2.0
        let marginHorizontal:CGFloat = width_2 - cellWidth_2
        let insets:UIEdgeInsets = UIEdgeInsets(
            top:0,
            left:marginHorizontal,
            bottom:0,
            right:marginHorizontal)
        
        return insets
    }
    
    override func scrollViewWillBeginDragging(
        _ scrollView:UIScrollView)
    {
        trackScroll = true
    }
    
    override func scrollViewDidEndScrollingAnimation(
        _ scrollView:UIScrollView)
    {
        trackScroll = true
    }
    
    override func scrollViewDidScroll(
        _ scrollView:UIScrollView)
    {
        if trackScroll
        {
            let offsetX:CGFloat = scrollView.contentOffset.x
            let midX:CGFloat = scrollView.bounds.width / 2.0
            let midY:CGFloat = scrollView.bounds.height / 2.0
            let totalX:CGFloat = midX + offsetX
            let point:CGPoint = CGPoint(x:totalX, y:midY)
            
            guard
                
                let indexPath:IndexPath = collectionView.indexPathForItem(at:point)
                
            else
            {
                return
            }
            
            collectionView.selectItem(
                at:indexPath,
                animated:true,
                scrollPosition:UICollectionViewScrollPosition())
            selectIndex(index:indexPath)
        }
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        layout collectionViewLayout:UICollectionViewLayout,
        sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        guard
        
            let cellSize:CGSize = self.cellSize
        
        else
        {
            let height:CGFloat = collectionView.bounds.height
            let cellSize:CGSize = CGSize(width:kCellWidth, height:height)
            self.cellSize = cellSize
            
            return cellSize
        }
        
        return cellSize
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model.minutes.count
        
        return count
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MEditDurationItem = modelAtIndex(index:indexPath)
        let cell:VEditDurationCell = cellAtIndex(indexPath:indexPath)
        cell.config(model:item)
        
        return cell
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        didSelectItemAt indexPath:IndexPath)
    {
        trackScroll = false
        
        collectionView.scrollToItem(
            at:indexPath,
            at:UICollectionViewScrollPosition.centeredHorizontally,
            animated:true)
        selectIndex(index:indexPath)
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MEditDurationItem
    {
        let item:MEditDurationItem = controller.model.minutes[index.item]
        
        return item
    }
    
    private func selectIndex(index:IndexPath)
    {
        controller.model.selectedMinute = index.item
        
        guard
            
            let view:VEditDuration = controller.view as? VEditDuration
            
        else
        {
            return
        }
        
        view.viewDisplay.update()
    }
    
    //MARK: public
    
    func selectCurrent()
    {
        let selected:Int = controller.model.selectedMinute
        let index:IndexPath = IndexPath(item:selected, section:0)
        
        collectionView.selectItem(
            at:index,
            animated:true,
            scrollPosition:
            UICollectionViewScrollPosition.centeredHorizontally)
    }
}
