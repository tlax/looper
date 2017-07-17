import UIKit

class VCameraPickerBar:UIView
{
    private weak var controller:CCameraPicker!
    
    init(controller:CCameraPicker)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let title:UILabel = UILabel()
        title.isUserInteractionEnabled = false
        title.translatesAutoresizingMaskIntoConstraints = false
        title.backgroundColor = UIColor.clear
        title.font = UIFont.bold(size:14)
        title.textAlignment = NSTextAlignment.center
        title.text = NSLocalizedString("VCameraPickerBar_title", comment:"")
        
        addSubview(title)
        
        NSLayoutConstraint.equals(
            view:title,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
