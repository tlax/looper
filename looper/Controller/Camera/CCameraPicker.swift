import UIKit

class CCameraPicker:UIImagePickerController, UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    private weak var camera:CCamera!
    private weak var model:MCameraRaw?
    
    convenience init(camera:CCamera, model:MCameraRaw?)
    {
        self.init()
        sourceType = UIImagePickerControllerSourceType.photoLibrary
        delegate = self
        allowsEditing = false
        self.camera = camera
        self.model = model
    }
    
    //MARK: private
    
    private func renderNew(image:UIImage)
    {
        let item:MCameraRawItem = MCameraRawItem(image:image)
        let modelSpeed:MCameraSpeed1 = MCameraSpeed1()
        let model:MCameraRaw = MCameraRaw(speed:modelSpeed)
        
        model.items.append(item)
        
        MSession.sharedInstance.camera?.renderRecording(modelRaw:model)
    }
    
    private func render(image:UIImage?)
    {
        guard
        
            let image:UIImage = image
        
        else
        {
            return
        }
        
        guard
        
            let model:MCameraRaw = self.model
        
        else
        {
            renderNew(image:image)
            
            return
        }
    }
    
    //MARK: imagePicker delegate
    
    func imagePickerController(_ picker:UIImagePickerController, didFinishPickingMediaWithInfo info:[String:Any])
    {
        let image:UIImage? = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        render(image:image)
        camera.dismiss(animated:true)
    }
}
