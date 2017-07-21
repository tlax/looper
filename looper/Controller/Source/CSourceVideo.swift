import Foundation

class CSourceVideo:Controller<VSourceVideo, MSourceVideo>
{
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
