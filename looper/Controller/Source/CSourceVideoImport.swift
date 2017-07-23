import UIKit

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
    
    override func didReceiveMemoryWarning()
    {
        model.cancelImport()
        
        let message:String = String.localizedController(
            key:"CSourceVideoImport_memoryWarning")
        VAlert.messageFail(message:message)
        
        cancel()
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
    
    private func asyncUpdateProgress(percent:CGFloat)
    {
        guard
            
            let view:VSourceVideoImport = self.view as? VSourceVideoImport
            
        else
        {
            return
        }
        
        view.viewProgress.updateProgress(percent:percent)
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
    
    func updateProgress(percent:CGFloat)
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.asyncUpdateProgress(percent:percent)
        }
    }
}
