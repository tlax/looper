import UIKit

class MCameraMoreItemActionsOptionScale:MCameraMoreItemActionsOption
{
    init()
    {
        super.init(image:#imageLiteral(resourceName: "assetCameraScale"))
    }
    
    override func selected(controller:CCameraMore?)
    {
        guard
            
            let record:MCameraRecord = controller?.record
            
        else
        {
            return
        }
        
        controller?.controller.scale(item:record)
    }
}
