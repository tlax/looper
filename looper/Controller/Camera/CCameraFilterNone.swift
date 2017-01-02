import UIKit

class CCameraFilterNone:CController
{
    let model:MCamera
    private weak var viewNone:VCameraFilterNone!
    
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
        let viewNone:VCameraFilterNone = VCameraFilterNone(controller:self)
        self.viewNone = viewNone
        view = viewNone
    }
}
