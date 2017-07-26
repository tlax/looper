import Foundation

class CEditDuration:Controller<VEditDuration, MEditDuration>
{
    init(edit:MEdit)
    {
        super.init()
        model.config(edit:edit)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        guard
        
            let view:VEditDuration = self.view as? VEditDuration
        
        else
        {
            return
        }
        
        view.viewDidAppear()
    }
    
    //MARK: public
    
    func okay()
    {
        guard
        
            let parent:ControllerParent = self.parent as? ControllerParent
        
        else
        {
            return
        }
        
        model.exportDuration()
        parent.dismissAnimateOver(completion:nil)
    }
}
