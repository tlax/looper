import UIKit

class VEditCropImageCorner:UIView
{
    let kLineWidth:CGFloat = 4
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
