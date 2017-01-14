import UIKit

class VCameraRotate:VView
{
    private weak var controller:CCameraRotate!
    private let kBarHeight:CGFloat = 64
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CCameraRotate
        
        let blur:VBlur = VBlur.extraLight()
        
        let bar:VCameraRotateBar = VCameraRotateBar(controller:self.controller)
        
        addSubview(blur)
        addSubview(bar)
        
        let constraintsBlur:[NSLayoutConstraint] = NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        let constraintsBarHorizontal:[NSLayoutConstraint] = NSLayoutConstraint.equalsHorizontal(
            view:bar,
            toView:self)
        
        let layoutBarTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:bar,
            toView:self)
        let layoutBarHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:bar,
            constant:kBarHeight)
        
        addConstraints(constraintsBlur)
        addConstraints(constraintsBarHorizontal)
        
        addConstraints([
            layoutBarTop,
            layoutBarHeight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
