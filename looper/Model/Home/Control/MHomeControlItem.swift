import UIKit

class MHomeControlItem
{
    let name:String
    let image:UIImage
    
    init(name:String, image:UIImage)
    {
        self.name = name
        self.image = image
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
