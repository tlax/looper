import UIKit

class VHomeControlCameraMenuTrigger:UIButton
{
    private weak var controller:CHome!
    private(set) var active:Bool
    
    init(controller:CHome)
    {
        active = false
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        imageView!.contentMode = UIViewContentMode.center
        imageView!.clipsToBounds = true
        addTarget(
            self,
            action:#selector(self.actionTrigger(sender:)),
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
        active = !active
        
        if active
        {
            controller.viewHome.viewControl.viewCamera?.viewMenu.blockButtons()
            stateRecording()
        }
        else
        {
            controller.viewHome.viewControl.viewCamera?.viewMenu.releaseButtons()
            stateStandBy()
        }
        
        controller.viewHome.viewControl.viewCamera?.actionTrigger(
            activate:active)
    }
    
    //MARK: private
    
    private func stateStandBy()
    {
        setImage(
            #imageLiteral(resourceName: "assetHomeCameraTriggerStand"),
            for:UIControlState.normal)
        setImage(
            #imageLiteral(resourceName: "assetHomeCameraTriggerHighlighted"),
            for:UIControlState.highlighted)
    }
    
    private func stateRecording()
    {
        setImage(
            #imageLiteral(resourceName: "assetHomeCameraTriggerStop"),
            for:UIControlState.normal)
        setImage(
            #imageLiteral(resourceName: "assetHomeCameraTriggerStopHighlighted"),
            for:UIControlState.highlighted)
    }
    
    //MARK: public
    
    func stop()
    {
        if active
        {
            actionTrigger(sender:self)
        }
    }
}
