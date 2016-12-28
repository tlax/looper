import UIKit

class VCameraShootMenuTrigger:UIButton
{
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        imageView!.contentMode = UIViewContentMode.center
        imageView!.clipsToBounds = true
        
        stateStandBy()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func stateStandBy()
    {
        setImage(
            #imageLiteral(resourceName: "assetCameraTriggerStand"),
            for:UIControlState.normal)
        setImage(
            #imageLiteral(resourceName: "assetCameraTriggerHighlighted"),
            for:UIControlState.highlighted)
    }
    
    func stateRecording()
    {
        setImage(
            #imageLiteral(resourceName: "assetCameraTriggerStop"),
            for:UIControlState.normal)
        setImage(
            #imageLiteral(resourceName: "assetCameraTriggerStopHighlighted"),
            for:UIControlState.highlighted)
    }
}
