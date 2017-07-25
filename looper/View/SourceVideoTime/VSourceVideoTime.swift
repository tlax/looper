import UIKit

class VSourceVideoTime:ViewMain
{
    static let kBarMaxHeight:CGFloat = 320
    static let kBottomBarHeight:CGFloat = 60
    private(set) weak var layoutBarHeight:NSLayoutConstraint!
    
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
        
        let viewInfo:VSourceVideoTimeInfo = VSourceVideoTimeInfo(
            controller:controller)
        
        addSubview(viewInfo)
        addSubview(viewBar)
        addSubview(viewBottomBar)
        
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        layoutBarHeight = NSLayoutConstraint.height(
            view:viewBar,
            constant:VSourceVideoTime.kBarMaxHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:viewInfo,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:viewBottomBar,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBottomBar,
            constant:VSourceVideoTime.kBottomBarHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBottomBar,
            toView:self)
    }
}
