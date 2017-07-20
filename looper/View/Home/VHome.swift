import UIKit

class VHome:ViewMain
{
    private let kMenuHeight:CGFloat = 100
    
    required init(controller:UIViewController)
    {
        super.init(controller:controller)
        
        guard
            
            let controller:CHome = controller as? CHome
        
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
    
    private func factoryViews(controller:CHome)
    {
        let viewMenu:VHomeMenu = VHomeMenu(controller:controller)
        
        addSubview(viewMenu)
        
        NSLayoutConstraint.bottomToBottom(
            view:viewMenu,
            toView:self)
        NSLayoutConstraint.height(
            view:viewMenu,
            constant:kMenuHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewMenu,
            toView:self)
    }
}
