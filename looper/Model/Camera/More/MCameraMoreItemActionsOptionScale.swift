import UIKit

class MCameraMoreItemActionsOptionScale:MCameraMoreItemActionsOption
{
    override init()
    {
        super.init(image:#imageLiteral(resourceName: "assetCameraScale"))
    }
    
    override init(image:UIImage)
    {
        fatalError()
    }
}
