import UIKit

class CEditCrop:Controller<VEditCrop, MEditCrop>
{
    init(edit:MEdit)
    {
        super.init()
        model.config(edit:edit)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
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
