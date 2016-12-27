import UIKit

class VCamera:VView
{
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.genericDark
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
