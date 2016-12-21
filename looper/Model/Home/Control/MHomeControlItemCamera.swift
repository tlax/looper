import UIKit

class MHomeControlItemCamera:MHomeControlItem
{
    override init()
    {
        let name:String = NSLocalizedString(
            "MHomeControlItemCamera_name",
            comment:"")
        
        super.init(name:name, image:#imageLiteral(resourceName: "assetHomeCamera"))
    }
    
    override init(name:String, image:UIImage)
    {
        fatalError()
    }
    
    override func selected(controller:CHome)
    {
        controller.viewHome.showCamera()
    }
}
