import UIKit

class CCameraPicker:UIImagePickerController, UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    private weak var camera:CCamera!
    private weak var editable:MCameraRecordEditable?
    
    convenience init(camera:CCamera, editable:MCameraRecordEditable?)
    {
        self.init()
        sourceType = UIImagePickerControllerSourceType.photoLibrary
        delegate = self
        allowsEditing = false
        self.camera = camera
        self.editable = editable
    }
    
    //MARK: private
    
    private func renderModel(image:UIImage) -> MCameraRaw
    {
        let item:MCameraRawItem = MCameraRawItem(image:image)
        let modelSpeed:MCameraSpeed1 = MCameraSpeed1()
        let model:MCameraRaw = MCameraRaw(speed:modelSpeed)
        
        model.items.append(item)
        
        return model
    }
    
    private func render(image:UIImage?)
    {
        guard
        
            let camera:MCamera = MSession.sharedInstance.camera,
            let image:UIImage = image
        
        else
        {
            return
        }
        
        let model:MCameraRaw = renderModel(image:image)
        
        guard
        
            let editable:MCameraRecordEditable = self.editable
        
        else
        {
            camera.renderRecording(
                modelRaw:model)
            
            return
        }
        
        camera.appendRenderRecording(
            editable:editable,
            modelRaw:model)
    }
    
    //MARK: imagePicker delegate
    
    func imagePickerController(_ picker:UIImagePickerController, didFinishPickingMediaWithInfo info:[String:Any])
    {
        let image:UIImage? = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        render(image:image)
        camera.dismiss(animated:true)
    }
}
