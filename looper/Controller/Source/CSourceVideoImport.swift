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
    
    //MARK: private
    
    private func backToCreate()
    {
        guard
            
            let parent:ControllerParent = self.parent as? ControllerParent
            
        else
        {
            return
        }
        
        parent.popSilent(removeIndex:3)
        parent.popSilent(removeIndex:2)
        parent.pop(horizontal:ControllerParent.Horizontal.right)
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
    
    func videoImported(createItem:MCreateItem)
    {
        controllerTime.controllerVideo.controllerCreate.model.addItem(
            item:createItem)
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.backToCreate()
        }
    }
}
