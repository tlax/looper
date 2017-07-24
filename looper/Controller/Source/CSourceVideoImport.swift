import UIKit

class CSourceVideoImport:Controller<VSourceVideoImport, MSourceVideoImport>
{
    init(
        item:MSourceVideoItem,
        framesPerSecond:Int)
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
        DispatchQueue.main.async
        { [weak self] in
            
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
