import UIKit

class VCameraShoot:VView
{
    private weak var controller:CCameraShoot!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.black
        self.controller = controller as? CCameraShoot
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
