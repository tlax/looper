import UIKit

class VCameraRotateBar:UIView
{
    private weak var controller:CCameraRotate!
    
    convenience init(controller:CCameraRotate)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let border:UIView = UIView()
        border.isUserInteractionEnabled = false
        border.backgroundColor = UIColor(white:0, alpha:0.1)
        border.translatesAutoresizingMaskIntoConstraints = false
        border.clipsToBounds = true
        
        addSubview(border)
        
        let layoutBorderTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:border,
            toView:self)
        let layout
    }
}
