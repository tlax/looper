import UIKit

class MHomeControlItemCamera:MHomeControlItem
{
    private let kActive:Bool = true
    
    override init(controller:CHome)
    {
        let name:String = NSLocalizedString(
            "MHomeControlItemCamera_name",
            comment:"")
        
        super.init(
            name:name,
            image:#imageLiteral(resourceName: "assetHomeCamera"),
            active:kActive)
    }
    
    override init(name:String, image:UIImage, active:Bool)
    {
        fatalError()
    }
    
    override func selected(controller:CHome)
    {
        controller.viewHome.showCamera()
    }
}
