import UIKit

class MCameraMoreItemActionsOptionAdd:MCameraMoreItemActionsOption
{
    init()
    {
        super.init(image:#imageLiteral(resourceName: "assetCameraMoreAdd"))
    }
    
    override func selected(controller:CCameraMore?)
    {
        guard
            
            let record:MCameraRecord = controller?.record
            
        else
        {
            return
        }
        
        controller?.controller.picker(record:record)
    }
}
