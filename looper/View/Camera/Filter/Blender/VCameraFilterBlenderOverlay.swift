import UIKit

class VCameraFilterBlenderOverlay:VView
{
    private weak var controller:CCameraFilterBlenderOverlay!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CCameraFilterBlenderOverlay
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
