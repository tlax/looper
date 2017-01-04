import UIKit

class MLoopsOptionsItemTrash:MLoopsOptionsItem
{
    override init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetHomePlayerShare")
        
        super.init(image:image)
    }
    
    override init(image:UIImage)
    {
        fatalError()
    }
}
