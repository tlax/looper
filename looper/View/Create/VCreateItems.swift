import UIKit

class VCreateItems:VCollection<
    VCreate,
    MCreate,
    CCreate,
    VCreateItemsCell>
{
    private let kCellHeight:CGFloat = 120
    private let kInterItem:CGFloat = 1
    private let kCollectionBottom:CGFloat = 20
    
    required init(controller:CCreate)
    {
        super.init(controller:controller)
        collectionView.alwaysBounceVertical = true
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            let top:CGFloat = kInterItem + VCreate.kBarHeight + VCreate.kMenuHeight
            
            flow.minimumLineSpacing = kInterItem
            flow.sectionInset = UIEdgeInsets(
                top:top,
                left:0,
                bottom:kCollectionBottom,
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
        let item:MCreateItem = modelAtIndex(index:indexPath)
        let cell:VCreateItemsCell = cellAtIndex(indexPath:indexPath)
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
    
    private func modelAtIndex(index:IndexPath) -> MCreateItem
    {
        let item:MCreateItem = controller.model.items[index.item]
        
        return item
    }
}
