import Foundation
import Photos

class CSourceVideo:Controller<VSourceVideo, MSourceVideo>
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        model.checkAuth()
    }
    
    //MARK: public
    
    func back()
    {
        guard
        
            let parent:ControllerParent = parent as? ControllerParent
        
        else
        {
            return
        }
        
        parent.pop(horizontal:ControllerParent.Horizontal.right)
    }
}
