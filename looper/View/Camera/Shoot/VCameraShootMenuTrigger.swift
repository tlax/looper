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
        
        stopRecording()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func stopRecording()
    {
        setImage(
            #imageLiteral(resourceName: "assetCameraTriggerStand"),
            for:UIControlState.normal)
        setImage(
            #imageLiteral(resourceName: "assetCameraTriggerHighlighted"),
            for:UIControlState.highlighted)
    }
    
    func startRecording()
    {
        setImage(
            #imageLiteral(resourceName: "assetCameraTriggerStop"),
            for:UIControlState.normal)
        setImage(
            #imageLiteral(resourceName: "assetCameraTriggerStopHighlighted"),
            for:UIControlState.highlighted)
    }
}
