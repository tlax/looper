import UIKit

class CCamera:CController
{
    weak var viewCamera:VCamera!
    let model:MCamera

    override init()
    {
        model = MCamera()
        
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func loadView()
    {
        let viewCamera:VCamera = VCamera(controller:self)
        self.viewCamera = viewCamera
        view = viewCamera
    }
}
