import UIKit

class MCameraMoreItemActionsOptionTrash:MCameraMoreItemActionsOption
{
    override init()
    {
        super.init(image:#imageLiteral(resourceName: "assetCameraTrash"))
    }
    
    override init(image:UIImage)
    {
        fatalError()
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
