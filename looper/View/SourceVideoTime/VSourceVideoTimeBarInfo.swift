import UIKit

class VSourceVideoTimeBarInfo:VCollection<
    VSourceVideoTime,
    MSourceVideoTime,
    CSourceVideoTime,
    VSourceVideoTimeBarInfoCell>
{
    private var cellSize:CGSize?
    
    required init(controller:CSourceVideoTime)
    {
        super.init(controller:controller)
        collectionView.bounces = false
        collectionView.isScrollEnabled = false
        
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
        sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        guard
            
            let cellSize:CGSize = self.cellSize
        
        else
        {
            let width:CGFloat = collectionView.bounds.width
            let height:CGFloat = collectionView.bounds.height
            let count:CGFloat = CGFloat(controller.model.items.count)
            let cellWidth:CGFloat = width / count
            let cellSize:CGSize = CGSize(width:cellWidth, height:height)
            self.cellSize = cellSize
            
            return cellSize
        }
        
        return cellSize
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
        let cell:VSourceVideoTimeBarInfoCell = cellAtIndex(
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
