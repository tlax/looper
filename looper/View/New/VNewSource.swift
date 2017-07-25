import UIKit

class VNewSource:VCollection<
    VNew,
    MNew,
    CNew,
    VNewSourceCell>
{
    let kCellHeight:CGFloat = 60
    
    required init(controller:CNew)
    {
        super.init(controller:controller)
        collectionView.bounces = false
        collectionView.isScrollEnabled = false
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
        let item:MSourceProtocol = modelAtIndex(index:indexPath)
        let cell:VNewSourceCell = cellAtIndex(indexPath:indexPath)
        cell.config(model:item)
        
        return cell
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        didSelectItemAt indexPath:IndexPath)
    {
        collectionView.isUserInteractionEnabled = false
        
        let item:MSourceProtocol = modelAtIndex(index:indexPath)
        controller.open(item:item)
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MSourceProtocol
    {
        let item:MSourceProtocol = controller.model.items[index.item]
        
        return item
    }
}
