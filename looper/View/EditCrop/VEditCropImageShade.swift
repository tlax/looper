import UIKit

class VEditCropImageShade:UIView
{
    private let kBorderWidth:CGFloat = 1
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor(white:0, alpha:0.7)
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderWidth = kBorderWidth
        layer.borderColor = UIColor.white.cgColor
        
        let viewMask:VEditCropImageShadeMask = VEditCropImageShadeMask()
        mask = viewMask
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
