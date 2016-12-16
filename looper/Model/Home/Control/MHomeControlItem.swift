import UIKit

class MHomeControlItem
{
    let name:String
    
    init(name:String)
    {
        self.name = name
    }
    
    init()
    {
        fatalError()
    }
    
    //MARK: public
    
    func selected(controller:CHome)
    {
    }
}
