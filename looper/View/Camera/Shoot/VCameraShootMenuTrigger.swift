import UIKit

class VCameraShootMenuTrigger:UIButton
{
    private weak var controller:CCameraShoot!
    
    init(controller:CCameraShoot)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        imageView!.contentMode = UIViewContentMode.center
        imageView!.clipsToBounds = true
        addTarget(
            self,
            action:#selector(actionTrigger(sender:)),
            for:UIControlEvents.touchUpInside)
        self.controller = controller
        
        stateStandBy()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: actions
    
    func actionTrigger(sender button:UIButton)
    {
        controller.recording = !controller.recording
        
        if controller.recording
        {
//            controller.viewHome.viewControl.viewCamera?.viewMenu.blockButtons()
            stateRecording()
        }
        else
        {
//            controller.viewHome.viewControl.viewCamera?.viewMenu.releaseButtons()
            stateStandBy()
        }
        
//        controller.viewHome.viewControl.viewCamera?.actionTrigger(
//            activate:active)
    }
    
    //MARK: private
    
    private func stateStandBy()
    {
        setImage(
            #imageLiteral(resourceName: "assetCameraTriggerStand"),
            for:UIControlState.normal)
        setImage(
            #imageLiteral(resourceName: "assetCameraTriggerHighlighted"),
            for:UIControlState.highlighted)
    }
    
    private func stateRecording()
    {
        setImage(
            #imageLiteral(resourceName: "assetCameraTriggerStop"),
            for:UIControlState.normal)
        setImage(
            #imageLiteral(resourceName: "assetCameraTriggerStopHighlighted"),
            for:UIControlState.highlighted)
    }
    
    //MARK: public
    
    func stop()
    {
        if controller.recording
        {
            actionTrigger(sender:self)
        }
    }
}
