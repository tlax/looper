import UIKit

class VCameraPreview:VView
{
    private weak var controller:CCameraPreview!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CCameraPreview
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
