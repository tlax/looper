import UIKit

class VEditCropImageShade:UIView
{
    private let kBorderWidth:CGFloat = 1
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor(white:0, alpha:0.5)
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = kBorderWidth
        layer.borderColor = UIColor.white.cgColor
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
