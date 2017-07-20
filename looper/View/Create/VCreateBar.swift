import UIKit

class VCreateBar:View<VCreate, MCreate, CCreate>
{
    required init(controller:CCreate)
    {
        super.init(controller:controller)
        backgroundColor = UIColor(red:0.02, green:0.03, blue:0.04, alpha:1)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
