import UIKit

class VCameraScale:VView
{
    private weak var controller:CCameraScale!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CCameraScale
        
        let blur:VBlur = VBlur.extraLight()
        
        addSubview(blur)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
