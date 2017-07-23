import UIKit

class MSourceItemVideo:MSourceProtocol
{
    var icon:UIImage
    {
        get
        {
            return #imageLiteral(resourceName: "assetCreateVideo")
        }
    }
    
    var title:String
    {
        get
        {
            return String.localizedModel(key:"MSourceItemVideo_title")
        }
    }
    
    func controller(controllerCreate:CCreate) -> UIViewController
    {
        let video:CSourceVideo = CSourceVideo(controllerCreate:controllerCreate)
        
        return video
    }
}
