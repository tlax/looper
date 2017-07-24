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
        
        view.viewWillAppear()
    }
    
    //MARK: public
    
    func cancel()
    {
        guard
            
            let view:VNew = self.view as? VNew,
            let parent:ControllerParent = parent as? ControllerParent
            
        else
        {
            return
        }
        
        view.viewWillDisappear()
        parent.dismissAnimateOver(completion:nil)
    }
}
