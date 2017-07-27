import UIKit

class VEditCropImageShade:UIView
{
    weak var layoutLeft:NSLayoutConstraint!
    weak var layoutRight:NSLayoutConstraint!
    weak var layoutTop:NSLayoutConstraint!
    weak var layoutBottom:NSLayoutConstraint!
    private let kBorderWidth:CGFloat = 1
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor(white:0, alpha:0.6)
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderWidth = kBorderWidth
        layer.borderColor = UIColor.white.cgColor
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
