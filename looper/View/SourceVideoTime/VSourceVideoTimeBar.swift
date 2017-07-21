import UIKit

class VSourceVideoTimeBar:
View<VSourceVideoTime, MSourceVideoTime, CSourceVideoTime>
{
    required init(controller:CSourceVideoTime)
    {
        super.init(controller:controler)
    }
    
    required init?(coder: NSCoder)
    {
        return nil
    }
}
