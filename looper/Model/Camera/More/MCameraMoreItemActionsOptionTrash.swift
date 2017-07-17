import UIKit

class MCameraMoreItemActionsOptionTrash:MCameraMoreItemActionsOption
{
    init()
    {
        super.init(image:#imageLiteral(resourceName: "assetCameraTrash"))
    }
    
    override func selected(controller:CCameraMore?)
    {
        guard
            
            let record:MCameraRecord = controller?.record
        
        else
        {
            return
        }
        
        controller?.controller.trash(item:record)
    }
}
