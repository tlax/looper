import UIKit

class VSourceVideoTimeBottomBar:View<VSourceVideoTime, MSourceVideoTime, CSourceVideoTime>
{
    required init(controller:CSourceVideoTime)
    {
        super.init(controller:controller)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
