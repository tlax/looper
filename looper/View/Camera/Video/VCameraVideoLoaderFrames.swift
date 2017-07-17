import UIKit

class VCameraVideoLoaderFrames:UIView
{
    private weak var controller:CCameraVideoLoader!
    
    init(controller:CCameraVideoLoader)
    {
        super.init(frame:CGRect.zero)
        self.controller = controller
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    
}
