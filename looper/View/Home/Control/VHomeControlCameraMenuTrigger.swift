import UIKit

class VHomeControlCameraMenuTrigger:UIButton
{
    private weak var controller:CHome!
    private var active:Bool
    
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
            stateRecording()
        }
        else
        {
            stateStandBy()
        }
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
}
