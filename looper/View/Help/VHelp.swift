import UIKit

class VHelp:VView
{
    private weak var controller:CHelp!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CHelp
        
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
