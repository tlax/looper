import UIKit

class MHomeControlItemSequences:MHomeControlItem
{
    override init(controller:CHome)
    {
        let name:String = NSLocalizedString(
            "MHomeControlItemSequences_name",
            comment:"")
        
        let active:Bool
        
        if controller.modelImage.sequences.isEmpty
        {
            active = false
        }
        else
        {
            active = true
        }
        
        super.init(
            name:name,
            image:#imageLiteral(resourceName: "assetHomeCamera"),
            active:active)
    }
    
    override init(name:String, image:UIImage, active:Bool)
    {
        fatalError()
    }
    
    override func selected(controller:CHome)
    {
        controller.viewHome.showSequences()
    }
}
