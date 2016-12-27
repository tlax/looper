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
            height:kBarHeight)
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
    
    func animateOver(view:VView, completion:@escaping(() -> ()))
    {
        view.alpha = 0
        
        addSubview(view)
        
        view.constraints(
            initialLeft:0,
            initialRight:0,
            initialTop:0,
            initialBottom:0)
        
        UIView.animate(
            withDuration:kAnimationDuration,
            animations:
        { [weak view] in
            
            view?.alpha = 1
        })
        { (done:Bool) in
        
            completion()
        }
    }
    
    func push(currentView:VView, newView:VView, completion:@escaping(() -> ()))
    {
        let fullLeft:CGFloat = currentView.bounds.maxX
        let halfLeft:CGFloat = fullLeft / -2.0
        
        addSubview(newView)
        newView.constraints(
            initialLeft:fullLeft,
            initialRight:fullLeft,
            initialTop:0,
            initialBottom:0)
        
        layoutIfNeeded()
        
        currentView.layoutRight.constant = halfLeft
        currentView.layoutLeft.constant = halfLeft
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
    
    func dismissAnimateOver(view:VView, completion:@escaping(() -> ()))
    {
        UIView.animate(
            withDuration:kAnimationDuration,
            animations:
            { [weak view] in
                
                view?.alpha = 0
            })
        { [weak view] (done:Bool) in
            
            view?.removeFromSuperview()
            completion()
        }
    }
    
    func dismissPush(currentView:VView, previousView:VView, completion:@escaping(() -> ()))
    {
        let fullLeft:CGFloat = currentView.bounds.maxX
        currentView.layoutLeft.constant = fullLeft
        currentView.layoutRight.constant = fullLeft
        previousView.layoutLeft.constant = 0
        previousView.layoutRight.constant = 0
        
        UIView.animate(
            withDuration:kAnimationDuration,
            animations:
            {
                self.layoutIfNeeded()
            })
        { [weak currentView] (done:Bool) in
            
            currentView?.removeFromSuperview()
            completion()
        }
    }
}
