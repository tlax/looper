import UIKit

class MLoopsOptionsItemShare:MLoopsOptionsItem
{
    init()
    {
        let image:UIImage = #imageLiteral(resourceName: "assetLoopsShare")
        
        super.init(image:image)
    }
    
    override func selected(controller:CLoops, model:MLoopsItem)
    {
        controller.share(model:model)
    }
}
