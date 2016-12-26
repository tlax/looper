import UIKit

class MHomeControlItem
{
    let name:String
    let image:UIImage
    let active:Bool
    
    init(name:String, image:UIImage, active:Bool)
    {
        self.name = name
        self.image = image
        self.active = active
    }
    
    init(controller:CHome)
    {
        fatalError()
    }
    
    //MARK: public
    
    func selected(controller:CHome)
    {
    }
}
