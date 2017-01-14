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
        
        let viewBar:VCameraRotateBar = VCameraRotateBar(controller:self.controller)
        
        let viewHandler:VCameraRotateHandler = VCameraRotateHandler()
        
        addSubview(blur)
        addSubview(viewHandler)
        addSubview(viewBar)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:viewHandler,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBar,
            constant:kBarHeight)
        
        NSLayoutConstraint.topToBottom(
            view:viewHandler,
            toView:viewBar)
        NSLayoutConstraint.bottomToBottom(
            view:viewHandler,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
