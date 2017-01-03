import UIKit

class VCameraPreview:VView
{
    private weak var controller:CCameraPreview!
    private let kBarHeight:CGFloat = 50
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CCameraPreview
        
        let viewBar:VCameraPreviewBar = VCameraPreviewBar(controller:self.controller)
        
        addSubview(viewBar)
        
        let layoutBarBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:viewBar,
            toView:self)
        let layoutBarHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:viewBar,
            constant:kBarHeight)
        let layoutBarLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewBar,
            toView:self)
        let layoutBarRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:viewBar,
            toView:self)
        
        addConstraints([
            layoutBarBottom,
            layoutBarHeight,
            layoutBarLeft,
            layoutBarRight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
