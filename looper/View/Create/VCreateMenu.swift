import UIKit

class VCreateMenu:
    View<VCreate, MCreate, CCreate>,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
{
    private let margin2:CGFloat
    private let kCellWidth:CGFloat = 90
    private let kCellMargin:CGFloat = 5
    private let kDeselectTime:TimeInterval = 0.3
    
    required init(controller:CCreate)
    {
        margin2 = kCellMargin + kCellMargin
        
        super.init(controller:controller)
        backgroundColor = UIColor.colourBackgroundGray
        
        let collectionView:VCollection = VCollection()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceHorizontal = true
        collectionView.registerCell(cell:VCreateMenuCell.self)
        
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
        
        addSubview(collectionView)
        
        NSLayoutConstraint.equals(
            view:collectionView,
            toView:self)
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
    
    func collectionView(
        _ collectionView:UICollectionView,
        layout collectionViewLayout:UICollectionViewLayout,
        sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let height:CGFloat = collectionView.bounds.height
        let remainHeight:CGFloat = height - margin2
        let size:CGSize = CGSize(width:kCellWidth, height:remainHeight)
        
        return size
    }
    
    func numberOfSections(
        in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(
        _ collectionView:UICollectionView,
        numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model.source.count
        
        return count
    }
    
    func collectionView(
        _ collectionView:UICollectionView,
        cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MSourceProtocol = modelAtIndex(index:indexPath)
        let cell:VCreateMenuCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VCreateMenuCell.reusableIdentifier,
            for:indexPath) as! VCreateMenuCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(
        _ collectionView:UICollectionView,
        didSelectItemAt indexPath:IndexPath)
    {
        collectionView.isUserInteractionEnabled = false
        
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kDeselectTime)
        { [weak collectionView] in
            
            collectionView?.selectItem(
                at:nil,
                animated:true,
                scrollPosition:UICollectionViewScrollPosition())
            collectionView?.isUserInteractionEnabled = true
        }
    }
}
