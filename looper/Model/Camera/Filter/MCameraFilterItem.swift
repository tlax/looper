import UIKit

class MCameraFilterItem
{
    let title:String
    let image:UIImage
    
    init(title:String, image:UIImage)
    {
        self.title = title
        self.image = image
    }
    
    init()
    {
        fatalError()
    }
    
    //MARK: public
    
    func processController() -> CController?
    {
        return nil
    }
}
