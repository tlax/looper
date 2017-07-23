import UIKit

class CCreate:Controller<VCreate, MCreate>
{
    //MARK: private
    
    private func alertClose()
    {
        let alert:UIAlertController = UIAlertController(
            title:String.localizedController(key:"CCreate_alertCloseTitle"),
            message:nil,
            preferredStyle:UIAlertControllerStyle.actionSheet)
        
        let actionCancel:UIAlertAction = UIAlertAction(
            title:String.localizedController(key:"CCreate_alertCloseCancel"),
            style:
            UIAlertActionStyle.cancel)
        
        let actionDelete:UIAlertAction = UIAlertAction(
            title:String.localizedController(key:"CCreate_alertCloseClose"),
            style:UIAlertActionStyle.destructive)
        { [weak self] (action:UIAlertAction) in
            
            self?.confirmClose()
        }
        
        alert.addAction(actionDelete)
        alert.addAction(actionCancel)
        
        if let popover:UIPopoverPresentationController = alert.popoverPresentationController
        {
            popover.sourceView = view
            popover.sourceRect = CGRect.zero
            popover.permittedArrowDirections = UIPopoverArrowDirection.up
        }
        
        present(alert, animated:true, completion:nil)
    }
    
    private func confirmClose()
    {
        guard
        
            let parent:ControllerParent = parent as? ControllerParent
        
        else
        {
            return
        }
        
        parent.pop(vertical:ControllerParent.Vertical.bottom)
    }
    
    //MARK: public
    
    func close()
    {
        alertClose()
    }
    
    func selected(item:MSourceProtocol)
    {
        guard
            
            let parent:ControllerParent = self.parent as? ControllerParent
        
        else
        {
            return
        }
        
        let controller:UIViewController = item.controller(create:self)
        parent.push(
            controller:controller,
            horizontal:ControllerParent.Horizontal.right)
    }
}
