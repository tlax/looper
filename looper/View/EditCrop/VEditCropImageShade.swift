import UIKit

class VEditCropImageShade:UIView
{
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor(white:0, alpha:0.7)
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        
        let viewMask:VEditCropImageShadeMask = VEditCropImageShadeMask()
        mask = viewMask
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
