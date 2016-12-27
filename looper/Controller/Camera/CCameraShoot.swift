import UIKit

class CCameraShoot:CController
{
    private weak var viewCamera:VCameraShoot!
    
    override func loadView()
    {
        let viewCamera:VCameraShoot = VCameraShoot(controller:self)
        self.viewCamera = viewCamera
        view = viewCamera
    }
}
