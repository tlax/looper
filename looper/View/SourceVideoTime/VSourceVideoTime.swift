import UIKit

class VSourceVideoTime:ViewMain
{
    private weak var layoutBarHeight:NSLayoutConstraint!
    private let kBarMaxHeight:CGFloat = 300
    private let kBottomBarHeight:CGFloat = 60
    
    required init(controller:UIViewController)
    {
        super.init(controller:controller)
        
        guard
        
            let controller:CSourceVideoTime = self.controller as? CSourceVideoTime
        
        else
        {
            return
        }
        
        factoryViews(controller:controller)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: private
    
    private func factoryViews(controller:CSourceVideoTime)
    {
        let viewBar:VSourceVideoTimeBar = VSourceVideoTimeBar(
            controller:controller)
        
        let viewBottomBar:VSourceVideoTimeBottomBar = VSourceVideoTimeBottomBar(
            controller:controller)
        
        addSubview(viewBar)
        addSubview(viewBottomBar)
        
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        layoutBarHeight = NSLayoutConstraint.height(
            view:viewBar,
            constant:kBarMaxHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:viewBottomBar,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBottomBar,
            constant:kBottomBarHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBottomBar,
            toView:self)
    }
}
