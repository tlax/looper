import UIKit

class VCameraFilterBlenderOverlayPlacer:UIView
{
    private weak var controller:CCameraFilterBlenderOverlay!
    
    convenience init(controller:CCameraFilterBlenderOverlay)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        self.controller = controller
    }
}
