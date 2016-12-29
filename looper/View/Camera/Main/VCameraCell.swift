import UIKit

class VCameraCell:UICollectionViewCell
{
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.gray
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
