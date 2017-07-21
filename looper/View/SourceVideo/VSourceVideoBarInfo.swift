import UIKit

class VSourceVideoBarInfo:View<VSourceVideo, MSourceVideo, CSourceVideo>
{
    required init(controller:CSourceVideo)
    {
        super.init(controller:controller)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func config(model:MSourceVideoItem)
    {
        
    }
}
