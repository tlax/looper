import Foundation

class CSourceVideoTime:Controller<VSourceVideoTime, MSourceVideoTime>
{
    private(set) weak var video:CSourceVideo!
    
    init(item:MSourceVideoItem)
    {
        super.init()
        model.config(item:item)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func close()
    {
        guard
        
            let parent:ControllerParent = self.parent as? ControllerParent
        
        else
        {
            return
        }
        
        parent.dismissAnimateOver(completion:nil)
    }
    
    func add()
    {
        guard
            
            let parent:ControllerParent = self.parent as? ControllerParent
            
        else
        {
            return
        }
        
        let controller:CSourceVideoImport = CSourceVideoImport(
            item:model.item,
            framesPerSecond:model.framesPerSecond)
        parent.animateOver(controller:controller)
    }
}
