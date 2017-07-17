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
            
            let editable:MCameraRecordEditable = controller?.record
            
        else
        {
            return
        }
        
        controller?.controller.picker(editable:editable)
    }
}
