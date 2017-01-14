import UIKit

class VCameraRotate:VView
{
    private weak var controller:CCameraRotate!
    private weak var imageView:UIImageView!
    private weak var viewHandler:VCameraRotateHandler!
    private let kBarHeight:CGFloat = 64
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CCameraRotate
        
        let blur:VBlur = VBlur.extraLight()
        
        let bar:VCameraRotateBar = VCameraRotateBar(controller:self.controller)
        
        let viewHandler:VCameraRotateHandler = VCameraRotateHandler()
        
        addSubview(blur)
        addSubview(viewHandler)
        addSubview(bar)
        
        let constraintsBlur:[NSLayoutConstraint] = NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        let constraintsBarHorizontal:[NSLayoutConstraint] = NSLayoutConstraint.equalsHorizontal(
            view:bar,
            toView:self)
        let constraintsHandlerHorizontal:[NSLayoutConstraint] = NSLayoutConstraint.equalsHorizontal(
            view:viewHandler,
            toView:self)
        
        let layoutBarTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:bar,
            toView:self)
        let layoutBarHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:bar,
            constant:kBarHeight)
        
        let layoutHandlerTop:NSLayoutConstraint = NSLayoutConstraint.topToBottom(
            view:viewHandler,
            toView:bar)
        let layoutHandlerBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:viewHandler,
            toView:self)
        
        addConstraints(constraintsBlur)
        addConstraints(constraintsBarHorizontal)
        addConstraints(constraintsHandlerHorizontal)
        
        addConstraints([
            layoutBarTop,
            layoutBarHeight,
            layoutHandlerTop,
            layoutHandlerBottom])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
