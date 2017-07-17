import UIKit

class CCameraPicker:UIImagePickerController, UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    private weak var camera:CCamera!
    private weak var record:MCameraRecord?
    
    convenience init(camera:CCamera, record:MCameraRecord?)
    {
        self.init()
        sourceType = UIImagePickerControllerSourceType.photoLibrary
        delegate = self
        allowsEditing = false
        self.camera = camera
        self.record = record
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
    
    //MARK: imagePicker delegate
    
    func imagePickerController(_ picker:UIImagePickerController, didFinishPickingMediaWithInfo info:[String:Any])
    {
        let image:UIImage? = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        render(image:image)
        camera.dismiss(animated:true)
    }
}
