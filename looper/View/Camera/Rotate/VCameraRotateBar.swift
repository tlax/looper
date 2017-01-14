import UIKit

class VCameraRotateBar:UIView
{
    private weak var controller:CCameraRotate!
    private let kBorderHeight:CGFloat = 1
    
    convenience init(controller:CCameraRotate)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let border:VBorder = VBorder(color:UIColor(white:0, alpha:0.1))
        addSubview(border)
        
        let constraintsBorderHorizontal:[NSLayoutConstraint] = NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
        
        let layoutBorderBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        let layoutBorderHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        
        addConstraints(constraintsBorderHorizontal)
        
        addConstraints([
            layoutBorderBottom,
            layoutBorderHeight])
    }
}
