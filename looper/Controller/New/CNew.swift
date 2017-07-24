import Foundation

class CNew:Controller<VNew, MNew>
{
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        guard
        
            let view:VNew = self.view as? VNew
        
        else
        {
            return
        }
        
        view.viewDidAppear()
    }
    
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
