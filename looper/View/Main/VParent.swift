import UIKit

class VParent:UIView
{
    private weak var controller:CParent!
    private weak var viewBar:VParentBar!
    private weak var layoutBarTop:NSLayoutConstraint!
    private let kAnimationDuration:TimeInterval = 0.3
    private let kBarHeight:CGFloat = 64
    
    convenience init(controller:CParent)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.white
        self.controller = controller
        
        let viewBar:VParentBar = VParentBar(controller:controller)
        self.viewBar = viewBar
        
        addSubview(viewBar)
        
        layoutBarTop = NSLayoutConstraint.topToTop(
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
    
    //MARK: public
    
    func mainView(view:VView)
    {
        addSubview(view)
        
        view.constraints(
            initialLeft:0,
            initialRight:0,
            initialTop:0,
            initialBottom:0)
    }
}
