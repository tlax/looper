import UIKit

class VCamera:VView
{
    private weak var collectionView:UICollectionView!
    private let kHeaderHeight:CGFloat = 150
    private let kCollectionBottom:CGFloat = 50
    private let kInterLine:CGFloat = 1
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize(width:0, height:kHeaderHeight)
        flow.footerReferenceSize = CGSize.zero
        flow.minimumLineSpacing = kInterLine
        flow.scrollDirection = UICollectionViewScrollDirection.vertical
        flow.sectionInset = UIEdgeInsets(
            top:0,
            left:0,
            bottom:kCollectionBottom,
            right:0)
        
        let collectionView:UICollectionView = UICollectionView(
            frame:CGRect.zero,
            collectionViewLayout:flow)
        self.collectionView = collectionView
        
        addSubview(collectionView)
        
        let layoutCollectionTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:collectionView,
            toView:self)
        let layoutCollectionBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:collectionView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
