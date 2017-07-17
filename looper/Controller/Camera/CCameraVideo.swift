import UIKit

class CCameraVideo:UIImagePickerController, UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    private weak var camera:CCamera!
    private weak var record:MCameraRecord?
    
    convenience init(camera:CCamera)
    {
        self.init()
        sourceType = UIImagePickerControllerSourceType.photoLibrary
        delegate = self
        allowsEditing = false
        self.camera = camera
    }
    
    //MARK: private
    
    private func render()
    {
        
    }
    
    //MARK: imagePicker delegate
    
    func imagePickerController(_ picker:UIImagePickerController, didFinishPickingMediaWithInfo info:[String:Any])
    {
        let image:UIImage? = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        camera.dismiss(animated:true)
    }
}
