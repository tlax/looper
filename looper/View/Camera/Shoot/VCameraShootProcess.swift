import UIKit

class VCameraShootProcess:UIView
{
    private weak var controller:CCameraShoot!
    
    convenience init(controller:CCameraShoot)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = false
        self.controller = controller
    }
    
    
}
