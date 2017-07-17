import UIKit
import Photos

class CCameraPicker:CController
{
    private weak var camera:CCamera!
    private weak var record:MCameraRecord?
    
    init(camera:CCamera, record:MCameraRecord?)
    {
        super.init()
        self.camera = camera
        self.record = record
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: private
    
    private func render(image:UIImage?)
    {
        guard
        
            let camera:MCamera = MSession.sharedInstance.camera,
            let image:UIImage = image
        
        else
        {
            return
        }
        
        let model:MCameraImage = MCameraImage(image:image)
        
        guard
        
            let record:MCameraRecord = self.record
        
        else
        {
            camera.renderImage(modelImage:model)
            
            return
        }
        
        camera.renderImage(record:record, modelImage:model)
    }
    
    /*
 
 func imagePickerController(_ picker:UIImagePickerController, didFinishPickingMediaWithInfo info:[String:Any])
 {
 let image:UIImage? = info[UIImagePickerControllerOriginalImage] as? UIImage
 
 render(image:image)
 camera.dismiss(animated:true)
 }
 
 */
}
