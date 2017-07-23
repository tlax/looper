import Foundation

class CSourceVideoImport:Controller<VSourceVideoImport, MSourceVideoImport>
{
    init(item:MSourceVideoItem, framesPerSecond:Int)
    {
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
        
        model.importVideo()
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
