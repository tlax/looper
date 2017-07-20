import UIKit

class VCreateMenu:View<VCreate, MCreate, CCreate>
{
    required init(controller:CCreate)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.colourBackgroundGray
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
