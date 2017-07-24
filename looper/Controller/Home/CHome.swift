import Foundation

class CHome:Controller<VHome, MHome>
{
    //MARK: public
    
    func openNew()
    {
        guard
            
            let parent:ControllerParent = self.parent as? ControllerParent
            
        else
        {
            return
        }
        
        let controller:CNew = CNew()
        parent.centreOver(controller:controller)
    }
}
