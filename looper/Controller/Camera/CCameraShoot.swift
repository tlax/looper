import UIKit

class CCameraShoot:CController
{
    private weak var viewCamera:VCameraShoot!
    private weak var model:MCamera?
    
    init(model:MCamera)
    {
        self.model = model
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func loadView()
    {
        let viewCamera:VCameraShoot = VCameraShoot(controller:self)
        self.viewCamera = viewCamera
        view = viewCamera
    }
}
