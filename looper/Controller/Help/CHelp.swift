import UIKit

class CHelp:CController
{
    //MARK: public
    
    func back()
    {
        parentController.pop(
            vertical:CParent.TransitionVertical.fromBottom)
    }
}
