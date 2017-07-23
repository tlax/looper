import Foundation

class CSourceVideoImport:Controller<VSourceVideoImport, MSourceVideoImport>
{
    private(set) weak var controllerTime:CSourceVideoTime!
    
    init(
        item:MSourceVideoItem,
        framesPerSecond:Int,
        controllerTime:CSourceVideoTime)
    {
        self.controllerTime = controllerTime
        
        super.init()
        model.config(item:item, framesPerSecond:framesPerSecond)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        model.importVideo(controller:self)
    }
    
    //MARK: public
    
    func cancel()
    {
        guard
            
            let parent:ControllerParent = self.parent as? ControllerParent
            
        else
        {
            return
        }
        
        parent.dismissAnimateOver(completion:nil)
    }
}
