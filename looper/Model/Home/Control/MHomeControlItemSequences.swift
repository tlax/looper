import UIKit

class MHomeControlItemSequences:MHomeControlItem
{
    override init()
    {
        let name:String = NSLocalizedString(
            "MHomeControlItemSequences_name",
            comment:"")
        
        super.init(name:name, image:#imageLiteral(resourceName: "assetHomeCamera"))
    }
    
    override init(name:String, image:UIImage)
    {
        fatalError()
    }
    
    override func selected(controller:CHome)
    {
        controller.viewHome.showBlender()
    }
}
