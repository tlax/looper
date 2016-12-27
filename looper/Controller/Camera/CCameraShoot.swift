import UIKit

class CCameraShoot:CController
{
    var recording:Bool
    private weak var viewCamera:VCameraShoot!
    private weak var model:MCamera?
    
    init(model:MCamera)
    {
        recording = false
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
    
    //MARK: public
    
    func back()
    {
        parentController.pop(deltaX:0, deltaY:-1)
        
//        if buttonTrigger.active
//        {
//            controller.viewHome.viewControl.viewCamera?.actionTrigger(
//                activate:false)
//        }
//        
//        controller.viewHome.viewControl.viewCamera?.layoutTickerHeight = nil
//        controller.returnToHome()
    }
}
