import UIKit
import Photos

class CCameraPicker:CController
{
    let model:MCameraPicker
    private weak var camera:CCamera!
    private weak var record:MCameraRecord?
    private weak var viewPicker:VCameraPicker!
    
    init(camera:CCamera, record:MCameraRecord?)
    {
        model = MCameraPicker()
        
        super.init()
        self.camera = camera
        self.record = record
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func loadView()
    {
        let viewPicker:VCameraPicker = VCameraPicker(controller:self)
        self.viewPicker = viewPicker
        view = viewPicker
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
    
    //MARK: public
    
    func commit()
    {
        
    }
    
    func cancel()
    {
        
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
