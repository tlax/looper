import UIKit

class VHomeControlCameraMenuTrigger:UIButton
{
    private weak var controller:CHome!
    
    convenience init(controller:CHome)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        imageView!.contentMode = UIViewContentMode.center
        imageView!.clipsToBounds = true
        self.controller = controller
        
        stateStandBy()
    }
    
    //MARK: private
    
    private func stateStandBy()
    {
        setImage(
            #imageLiteral(resourceName: "assetHomeCameraTriggerStand"),
            for:UIControlState.normal)
    }
}
