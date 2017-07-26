import UIKit

class CEditCrop:Controller<VEditCrop, MEditCrop>
{
    override var preferredStatusBarStyle:UIStatusBarStyle
    {
        return UIStatusBarStyle.lightContent
    }
    
    //MARK: public
    
    func okay()
    {
        guard
            
            let parent:ControllerParent = self.parent as? ControllerParent
            
        else
        {
            return
        }
        
//        model.exportDuration()
        parent.dismissAnimateOver(completion:nil)
    }
}
