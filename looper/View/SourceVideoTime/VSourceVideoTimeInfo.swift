import UIKit

class VSourceVideoTimeInfo:VCollection<
    VSourceVideoTime,
    MSourceVideoTime,
    CSourceVideoTime,
    VSourceVideoTimeInfoCell>
{
    private let kInterItem:CGFloat = 2
    
    required init(controller:CSourceVideoTime)
    {
        super.init(controller:controller)
        collectionView.alwaysBounceVertical = true
        
        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            flow.minimumLineSpacing = kInterItem
            flow.sectionInset = UIEdgeInsets(
                top:VSourceVideoTime.kBarMaxHeight,
                left:0,
                bottom:VSourceVideoTime.kBottomBarHeight,
                right:0)
        }
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
