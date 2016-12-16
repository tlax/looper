import UIKit

class MHomeControlItemCamera:MHomeControlItem
{
    override init()
    {
        let name:String = NSLocalizedString(
            "MHomeControlItemCamera_name",
            comment:"")
        
        super.init(name:name)
    }
    
    override init(name:String)
    {
        fatalError()
    }
    
    override func selected(controller:CHome)
    {
        controller.viewHome.showCamera()
    }
}
