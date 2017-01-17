import UIKit

class CCameraCrop:CController
{
    private weak var viewCrop:VCameraCrop!
    
    override func loadView()
    {
        let viewCrop:VCameraCrop = VCameraCrop(controller:self)
        self.viewCrop = viewCrop
        view = viewCrop
    }
    
    //MARK: public
    
    func save()
    {
        parentController.pop(vertical:CParent.TransitionVertical.fromBottom)
    }
}
