import UIKit

class VCreate:ViewMain
{
    static let kBarHeight:CGFloat = 64
    static let kMenuHeight:CGFloat = 80
    
    private(set) weak var viewItems:VCreateItems!
    
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
        
        let viewItems:VCreateItems = VCreateItems(controller:controller)
        self.viewItems = viewItems
        
        addSubview(viewItems)
        addSubview(viewBar)
        addSubview(viewMenu)
        
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBar,
            constant:VCreate.kBarHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:viewMenu,
            toView:viewBar)
        NSLayoutConstraint.height(
            view:viewMenu,
            constant:VCreate.kMenuHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewMenu,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:viewItems,
            toView:self)
    }
}
