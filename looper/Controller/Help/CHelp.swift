import UIKit

class CHelp:CController
{
    private weak var viewHelp:VHelp!
    
    override func loadView()
    {
        let viewHelp:VHelp = VHelp(controller:self)
        self.viewHelp = viewHelp
        view = viewHelp
    }
    
    //MARK: public
    
    func back()
    {
        parentController.pop(
            vertical:CParent.TransitionVertical.fromBottom)
    }
}
