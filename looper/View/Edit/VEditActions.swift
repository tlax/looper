import UIKit

class VEditActions:VCollection<
    VEdit,
    MEdit,
    CEdit,
    VEditActionsCell>
{
    private var cellSize:CGSize?
    
    required init(controller:CEdit)
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
            let count:CGFloat = CGFloat(controller.model.actions.count)
            let width:CGFloat = collectionView.bounds.width
            let height:CGFloat = collectionView.bounds.height
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
        let count:Int = controller.model.actions.count
        
        return count
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MEditActionProtocol = modelAtIndex(index:indexPath)
        let cell:VEditActionsCell = cellAtIndex(indexPath:indexPath)
        cell.config(model:item)
        
        return cell
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        didSelectItemAt indexPath:IndexPath)
    {
        super.collectionView(
            collectionView,
            didSelectItemAt:indexPath)
        
        let item:MEditActionProtocol = modelAtIndex(index:indexPath)
        controller.selected(item:item)
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MEditActionProtocol
    {
        let item:MEditActionProtocol = controller.model.actions[index.item]
        
        return item
    }
}
