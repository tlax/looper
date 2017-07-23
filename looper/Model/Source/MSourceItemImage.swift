import UIKit

class MSourceItemImage:MSourceProtocol
{
    var icon:UIImage
    {
        get
        {
            return #imageLiteral(resourceName: "assetCreateImage")
        }
    }
    
    var title:String
    {
        get
        {
            return String.localizedModel(key:"MSourceItemImage_title")
        }
    }
    
    func controller(controllerCreate:CCreate) -> UIViewController
    {
        let video:CSourceImage = CSourceImage(controllerCreate:controllerCreate)
        
        return video
    }
}
