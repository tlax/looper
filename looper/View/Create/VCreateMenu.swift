import UIKit

class VCreateMenu:
    View<VCreate, MCreate, CCreate>,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
{
    private let margin2:CGFloat
    private let kCellWidth:CGFloat = 80
    private let kCellMargin:CGFloat = 2
    
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
        return 0
    }
    
    func collectionView(
        _ collectionView:UICollectionView,
        cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let cell:VCreateMenuCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VCreateMenuCell.reusableIdentifier,
            for:indexPath) as! VCreateMenuCell
        
        return cell
    }
}
