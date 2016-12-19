import UIKit

class VHomeTimelineCell:UICollectionViewCell
{
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        backgroundColor = UIColor.white
        clipsToBounds =  true
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
