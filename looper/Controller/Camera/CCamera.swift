import UIKit

class CCamera:CController
{
    weak var viewCamera:VCamera!
    
    override func loadView()
    {
        let viewCamera:VCamera = VCamera(controller:self)
        self.viewCamera = viewCamera
        view = viewCamera
    }
}
