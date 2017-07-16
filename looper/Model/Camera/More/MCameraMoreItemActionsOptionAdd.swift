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
            
            let record:MCameraRecordEditable = controller?.record
            
        else
        {
            return
        }
        
        controller?.controller.trash(item:record)
    }
}
