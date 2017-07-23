import Foundation

class CNew:Controller<VNew, MNew>
{
    //MARK: public
    
    func cancel()
    {
        guard
            
            let parent:ControllerParent = parent as? ControllerParent
            
        else
        {
            return
        }
        
        parent.dismissAnimateOver(completion:nil)
    }
}
