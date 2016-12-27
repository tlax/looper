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
        
        view.layoutTop = NSLayoutConstraint.topToBottom(
            view:view,
            toView:viewBar)
        view.layoutBottom = NSLayoutConstraint.bottomToBottom(
            view:view,
            toView:self)
        view.layoutLeft = NSLayoutConstraint.leftToLeft(
            view:view,
            toView:self)
        view.layoutRight = NSLayoutConstraint.rightToRight(
            view:view,
            toView:self)
        
        addConstraints([
            view.layoutTop,
            view.layoutBottom,
            view.layoutLeft,
            view.layoutRight])
    }
    
    func slide(
        currentView:VView,
        newView:VView,
        left:CGFloat,
        completion:@escaping(() -> ()))
    {
        addSubview(newView)
        
        newView.layoutTop = NSLayoutConstraint.topToBottom(
            view:newView,
            toView:viewBar)
        newView.layoutBottom = NSLayoutConstraint.bottomToBottom(
            view:newView,
            toView:self)
        newView.layoutLeft = NSLayoutConstraint.leftToLeft(
            view:newView,
            toView:self,
            constant:-left)
        newView.layoutRight = NSLayoutConstraint.rightToRight(
            view:newView,
            toView:self,
            constant:-left)
        
        addConstraints([
            newView.layoutTop,
            newView.layoutBottom,
            newView.layoutLeft,
            newView.layoutRight])
        
        layoutIfNeeded()
        
        currentView.layoutRight.constant = left
        currentView.layoutLeft.constant = left
        newView.layoutRight.constant = 0
        newView.layoutLeft.constant = 0
        
        UIView.animate(
        withDuration:kAnimationDuration,
        animations:
        {
            self.layoutIfNeeded()
        })
        { (done:Bool) in
            
            completion()
        }
    }
}
