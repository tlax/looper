import UIKit

class VCameraFilterNone:VView
{
    private weak var controller:CCameraFilterNone!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CCameraFilterNone
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
