import UIKit

class VCameraRotate:VView
{
    private weak var controller:CCameraRotate!
    private weak var imageView:UIImageView!
    private weak var viewHandler:VCameraRotateHandler!
    private let kBarHeight:CGFloat = 64
    private let kImageMargin:CGFloat = 120
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CCameraRotate
        
        let blur:VBlur = VBlur.extraLight()
        
        let viewBar:VCameraRotateBar = VCameraRotateBar(controller:self.controller)
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.image = self.controller.record.items.first?.image
        
        let viewHandler:VCameraRotateHandler = VCameraRotateHandler()
        
        addSubview(blur)
        addSubview(viewHandler)
        addSubview(imageView)
        addSubview(viewBar)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        NSLayoutConstraint.equals(
            view:imageView,
            toView:viewHandler,
            margin:kImageMargin)
        
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBar,
            constant:kBarHeight)
        
        NSLayoutConstraint.equalsHorizontal(
            view:viewHandler,
            toView:self)
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
    
    override func touchesBegan(_ touches:Set<UITouch>, with event:UIEvent?)
    {
    }
    
    override func touchesMoved(_ touches:Set<UITouch>, with event:UIEvent?)
    {
    }
    
    override func touchesEnded(_ touches:Set<UITouch>, with event:UIEvent?)
    {
    }
    
    override func touchesCancelled(_ touches:Set<UITouch>, with event:UIEvent?)
    {
    }
}
