import UIKit

class VCameraFilter:VView
{
    private weak var controller:CCameraFilter!
    private let kBarHeight:CGFloat = 64
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CCameraFilter
        
        let viewBar:VCameraFilterBar = VCameraFilterBar(
            controller:self.controller)
        
        addSubview(viewBar)
        
        let layoutBarTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
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
            layoutBarTop,
            layoutBarHeight,
            layoutBarLeft,
            layoutBarRight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
