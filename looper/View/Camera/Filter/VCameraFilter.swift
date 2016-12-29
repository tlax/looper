import UIKit

class VCameraFilter:VView
{
    private weak var controller:CCameraFilter!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CCameraFilter
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
