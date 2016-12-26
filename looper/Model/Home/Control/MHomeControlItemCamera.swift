import UIKit

class MHomeControlItemCamera:MHomeControlItem
{
    private let kActive:Bool = true
    
    override init(controller:CHome)
    {
        super.init(
            image:#imageLiteral(resourceName: "assetHomeCamera"),
            active:kActive)
    }
    
    override init(image:UIImage, active:Bool)
    {
        fatalError()
    }
    
    override func selected(controller:CHome)
    {
        controller.viewHome.showCamera()
    }
}
