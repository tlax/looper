import UIKit
import MobileCoreServices

class CCameraVideo:UIImagePickerController, UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    private weak var camera:CCamera!
    
    convenience init(camera:CCamera)
    {
        self.init()
        sourceType = UIImagePickerControllerSourceType.photoLibrary
        mediaTypes = [kUTTypeMovie as String]
        delegate = self
        allowsEditing = true
        self.camera = camera
    }
    
    //MARK: imagePicker delegate
    
    func imagePickerController(_ picker:UIImagePickerController, didFinishPickingMediaWithInfo info:[String:Any])
    {
        let url:URL? = info[UIImagePickerControllerMediaURL] as? URL
        camera.loadVideo(url:url)
    }
}
