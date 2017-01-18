import UIKit

class MCameraMoreItemActionsOptionScale:MCameraMoreItemActionsOption
{
    override init()
    {
        super.init(image:#imageLiteral(resourceName: "assetCameraScale"))
    }
    
    override func selected(controller:CCameraMore?)
    {
        guard
            
            let record:MCameraRecordEditable = controller?.record
            
        else
        {
            return
        }
        
        controller?.controller.scale(item:record)
    }
}
