import UIKit

class VCameraPreviewPlayerButton:UIButton
{
    private weak var controller:CCameraPreview!
    
    convenience init(controller:CCameraPreview)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        imageView!.contentMode = UIViewContentMode.center
        imageView!.clipsToBounds = true
        self.controller = controller
        
        play()
    }
    
    //MARK: public
    
    func stop()
    {
        setImage(
            #imageLiteral(resourceName: "assetCameraPlayerPause"),
            for:UIControlState.normal)
        setImage(
            #imageLiteral(resourceName: "assetCameraPlayerPauseSelected"),
            for:UIControlState.highlighted)
    }
    
    func play()
    {
        setImage(
            #imageLiteral(resourceName: "assetCameraPlayerPlay"),
            for:UIControlState.normal)
        setImage(
            #imageLiteral(resourceName: "assetCameraPlayerPlaySelected"),
            for:UIControlState.highlighted)
    }
}
