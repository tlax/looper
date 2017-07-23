import UIKit

class VNewSource:VCollection<
    VNew,
    MNew,
    CNew,
    VNewSourceCell>
{
    private let kCellHeight:CGFloat = 80
    
    required init(controller:CNew)
    {
        super.init(controller:controller)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        layout collectionViewLayout:UICollectionViewLayout,
        insetForSectionAt section:Int) -> UIEdgeInsets
    {
        
    }
}
