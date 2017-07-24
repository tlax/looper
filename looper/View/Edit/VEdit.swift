import UIKit

class VEdit:ViewMain
{
    required init(controller:UIViewController)
    {
        super.init(controller:controller)
        
        guard
        
            let controller:CEdit = controller as? CEdit
        
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
    
    private func factoryViews(controller:CEdit)
    {
        
    }
}
