import UIKit

class VCameraRotate:VView
{
    private weak var controller:CCameraRotate!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CCameraRotate
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
