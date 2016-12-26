import UIKit

class MHomeControlItem
{
    let image:UIImage
    let active:Bool
    
    init(image:UIImage, active:Bool)
    {
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
