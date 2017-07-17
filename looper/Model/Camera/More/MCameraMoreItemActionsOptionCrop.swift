import UIKit

class MCameraMoreItemActionsOptionCrop:MCameraMoreItemActionsOption
{
    init()
    {
        super.init(image:#imageLiteral(resourceName: "assetCameraCrop"))
    }
    
    override func selected(controller:CCameraMore?)
    {
        guard
            
            let record:MCameraRecord = controller?.record
            
        else
        {
            return
        }
        
        controller?.controller.crop(item:record)
    }
}
