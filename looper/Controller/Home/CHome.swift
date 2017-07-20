import Foundation

class CHome:Controller<VHome, MHome>
{
    //MARK: public
    
    func openCreate()
    {
        guard
            
            let parent:ControllerParent = self.parent as? ControllerParent
        
        else
        {
            return
        }
        
        let controller:CCreate = CCreate()
        parent.push(
            controller:controller,
            vertical:ControllerParent.Vertical.bottom)
    }
}
