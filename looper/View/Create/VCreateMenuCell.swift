import UIKit

class VCreateMenuCell:UICollectionViewCell
{
    private let kCornerRadius:CGFloat = 6
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.white
        layer.cornerRadius = kCornerRadius
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func config(model:MSourceProtocol)
    {
    }
}
