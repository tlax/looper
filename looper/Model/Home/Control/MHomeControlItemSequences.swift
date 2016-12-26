import UIKit

class MHomeControlItemSequences:MHomeControlItem
{
    private let kControl:VHomeControl.Control = VHomeControl.Control.sequences
    
    override init(controller:CHome)
    {
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
            image:#imageLiteral(resourceName: "assetHomeCamera"),
            active:active)
    }
    
    override init(image:UIImage, active:Bool)
    {
        fatalError()
    }
    
    override func selected(controller:CHome)
    {
        controller.viewHome.showControl(control:kControl)
    }
}
