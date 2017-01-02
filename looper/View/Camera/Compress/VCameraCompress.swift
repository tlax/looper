import UIKit

class VCameraCompress:VView
{
    private weak var controller:CCameraCompress!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CCameraCompress
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
