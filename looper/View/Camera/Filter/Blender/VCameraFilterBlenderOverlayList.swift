import UIKit

class VCameraFilterBlenderOverlayList:UIView
{
    private weak var controller:CCameraFilterBlenderOverlay!
    
    convenience init(controller:CCameraFilterBlenderOverlay)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
    }
}
