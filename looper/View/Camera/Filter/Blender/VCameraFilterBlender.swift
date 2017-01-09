import UIKit

class VCameraFilterBlender:VView
{
    private weak var controller:CCameraFilterBlender!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        
        self.controller = controller as? CCameraFilterBlender
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
