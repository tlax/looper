import UIKit

class MCameraMoreItemActionsOption
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
    
    func selected(controller:CCameraMore?, record:MCameraRecordEditable?)
    {
    }
}
