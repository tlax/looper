import Foundation
import Photos

class CSourceVideo:Controller<VSourceVideo, MSourceVideo>
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        model.checkAuth()
    }
    
    override func modelRefresh()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            guard
            
                let view:VSourceVideo = self?.view as? VSourceVideo
            
            else
            {
                return
            }
            
            view.refresh()
        }
    }
    
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
    
    func selected(item:MSourceVideoItem)
    {
        guard
            
            let parent:ControllerParent = parent as? ControllerParent
            
        else
        {
            return
        }
        
        let controller:CSourceVideoTime = CSourceVideoTime(
            item:item)
        parent.animateOver(controller:controller)
    }
}
