import UIKit

class VParent:UIView
{
    private weak var controller:CParent!
    private weak var viewBar:VParentBar!
    private weak var layoutBarTop:NSLayoutConstraint!
    private let kAnimationDuration:TimeInterval = 0.4
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
        insertSubview(view, belowSubview:viewBar)
        
        view.layoutTop = NSLayoutConstraint.topToTop(
            view:view,
            toView:self)
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
        insertSubview(newView, belowSubview:viewBar)
        
        newView.layoutTop = NSLayoutConstraint.topToTop(
            view:newView,
            toView:self)
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
            currentView.removeFromSuperview()
        }
    }
    
    func push(
        newView:VView,
        left:CGFloat,
        top:CGFloat,
        completion:@escaping(() -> ()))
    {
        addSubview(newView)
        
        newView.layoutTop = NSLayoutConstraint.topToTop(
            view:newView,
            toView:self,
            constant:top)
        newView.layoutBottom = NSLayoutConstraint.bottomToBottom(
            view:newView,
            toView:self,
            constant:top)
        newView.layoutLeft = NSLayoutConstraint.leftToLeft(
            view:newView,
            toView:self,
            constant:left)
        newView.layoutRight = NSLayoutConstraint.rightToRight(
            view:newView,
            toView:self,
            constant:left)
        
        addConstraints([
            newView.layoutTop,
            newView.layoutBottom,
            newView.layoutLeft,
            newView.layoutRight])
        
        layoutIfNeeded()
        
        newView.layoutTop.constant = 0
        newView.layoutBottom.constant = 0
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
    
    func pop(
        currentView:VView,
        left:CGFloat,
        top:CGFloat,
        completion:@escaping(() -> ()))
    {
        currentView.layoutTop.constant = top
        currentView.layoutBottom.constant = top
        currentView.layoutRight.constant = left
        currentView.layoutLeft.constant = left
        
        UIView.animate(
            withDuration:kAnimationDuration,
            animations:
        {
            self.layoutIfNeeded()
        })
        { (done:Bool) in
            
            completion()
            currentView.removeFromSuperview()
        }
    }
}
