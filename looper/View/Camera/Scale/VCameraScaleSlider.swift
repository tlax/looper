import UIKit

class VCameraScaleSlider:UIView
{
    private weak var labelPercent:UILabel!
    private weak var labelSize:UILabel!
    private weak var thumb:UIImageView!
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.red
        translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
