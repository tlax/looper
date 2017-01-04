import UIKit

class MLoopsOptionsItem
{
    let image:UIImage
    
    init(image:UIImage)
    {
        self.image = image
    }
    
    init()
    {
        fatalError()
    }
    
    //MARK: public
    
    func selected(controller:CLoops, model:MLoopsItem)
    {
    }
}
