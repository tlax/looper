import UIKit

class VCameraCrop:VView
{
    private weak var controller:CCameraCrop!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CCameraCrop
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
