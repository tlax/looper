import UIKit

class VCollection
    <T:ViewMain, S:Model, R:Controller<T, S>, Q:UICollectionViewCell>:
    View<T, S, R>,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
{
    private(set) weak var collectionView:UICollectionView!
    
    required convenience init(controller:R)
    {
        let flow:VCollectionFlow = VCollectionFlow()
        
        self.init(controller:controller, flow:flow)
    }
    
    init(controller:R, flow:UICollectionViewFlowLayout)
    {
        super.init(controller:controller)
        
        let collectionView:UICollectionView = UICollectionView(
            frame:CGRect.zero,
            collectionViewLayout:flow)
        collectionView.clipsToBounds = true
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        self.collectionView = collectionView
        
        addSubview(collectionView)
        
        NSLayoutConstraint.equals(
            view:collectionView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func registerCell(cell:Q.Type)
    {
        collectionView.register(
            cell,
            forCellWithReuseIdentifier:cell.reusableIdentifier)
    }
    
    func registerFooter(footer:UICollectionReusableView.Type)
    {
        collectionView.register(
            footer,
            forSupplementaryViewOfKind:UICollectionElementKindSectionFooter,
            withReuseIdentifier:footer.reusableIdentifier)
    }
    
    func registerHeader(header:UICollectionReusableView.Type)
    {
        collectionView.register(
            header,
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader,
            withReuseIdentifier:header.reusableIdentifier)
    }
    
    func cellAtIndex(reusableIdentifier:String, indexPath:IndexPath) -> Q
    {
        let cell:Q = collectionView.dequeueReusableCell(
            withReuseIdentifier:reusableIdentifier,
            for:indexPath) as! Q
        
        return cell
    }
    
    //MARK: collectionView delegate
    
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
        let cell:Q = cellAtIndex(
            reusableIdentifier:Q.reusableIdentifier,
            indexPath:indexPath)
        
        return cell
    }
}
