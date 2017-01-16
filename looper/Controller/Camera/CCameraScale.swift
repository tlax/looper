import UIKit

class CCameraScale:CController
{
    private weak var viewScale:VCameraScale!
    
    override func loadView()
    {
        let viewScale:VCameraScale = VCameraScale(controller:self)
        self.viewScale = viewScale
        view = viewScale
    }
    
    //MARK: public
    
    func save()
    {
        parentController.pop(
            vertical:CParent.TransitionVertical.fromBottom)
    }
}
