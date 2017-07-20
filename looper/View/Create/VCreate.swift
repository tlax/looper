import UIKit

class VCreate:ViewMain
{
    private let kBarMaxHeight:CGFloat = 150
    private let kMenuHeight:CGFloat = 100
    
    required init(controller:UIViewController)
    {
        super.init(controller:controller)
        
        guard
        
            let controller:CCreate = controller as? CCreate
        
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
    
    private func factoryViews(controller:CCreate)
    {
        let viewBar:VCreateBar = VCreateBar(controller:controller)
        
        let viewMenu:VCreateMenu = VCreateMenu(controller:controller)
        
        addSubview(viewBar)
        addSubview(viewMenu)
        
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBar,
            constant:kBarMaxHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:viewMenu,
            toView:viewBar)
        NSLayoutConstraint.height(
            view:viewMenu,
            constant:kMenuHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewMenu,
            toView:self)
    }
}
