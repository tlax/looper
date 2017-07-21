import UIKit

class VCreateMenu:VCollection<
    VCreate,
    MCreate,
    CCreate,
    VCreateMenuCell>
{
    private let margin2:CGFloat
    private let kCellWidth:CGFloat = 120
    private let kCellMargin:CGFloat = 2
    
    required init(controller:CCreate)
    {
        margin2 = kCellMargin + kCellMargin
        
        super.init(controller:controller)
        collectionView.alwaysBounceHorizontal = true
        backgroundColor = UIColor.colourBackgroundGray
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.scrollDirection = UICollectionViewScrollDirection.horizontal
            flow.minimumLineSpacing = kCellMargin
            flow.minimumInteritemSpacing = kCellMargin
            flow.sectionInset = UIEdgeInsets(
                top:kCellMargin,
                left:kCellMargin,
                bottom:kCellMargin,
                right:kCellMargin)
        }
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MSourceProtocol
    {
        let item:MSourceProtocol = controller.model.source[index.item]
        
        return item
    }
    
    //MARK: collectionView delegate
    
    override func collectionView(
        _ collectionView:UICollectionView,
        layout collectionViewLayout:UICollectionViewLayout,
        sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let height:CGFloat = collectionView.bounds.height
        let remainHeight:CGFloat = height - margin2
        let size:CGSize = CGSize(width:kCellWidth, height:remainHeight)
        
        return size
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model.source.count
        
        return count
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MSourceProtocol = modelAtIndex(index:indexPath)
        let cell:VCreateMenuCell = cellAtIndex(indexPath:indexPath)
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
        
        let item:MSourceProtocol = modelAtIndex(index:indexPath)
        controller.selected(item:item)
    }
}
