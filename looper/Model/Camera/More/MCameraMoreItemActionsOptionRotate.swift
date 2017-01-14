import UIKit

class MCameraMoreItemActionsOptionRotate:MCameraMoreItemActionsOption
{
    override init()
    {
        super.init(image:#imageLiteral(resourceName: "assetCameraRotate"))
    }
    
    override init(image:UIImage)
    {
        fatalError()
    }
}
