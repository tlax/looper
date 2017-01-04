import UIKit

class MLoopsOptionsItemShare:MLoopsOptionsItem
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
