import Foundation
import Photos

extension MSourceVideo
{
    func checkAuth()
    {
        switch PHPhotoLibrary.authorizationStatus()
        {
        case PHAuthorizationStatus.denied,
             PHAuthorizationStatus.restricted:
            
            authDenied()
            
            break
            
        case PHAuthorizationStatus.notDetermined:
            
            requestAuth()
            
            break
            
        case PHAuthorizationStatus.authorized:
            
            authorized()
            
            break
        }
    }
    
    //MARK: private
    
    private func requestAuth()
    {
        PHPhotoLibrary.requestAuthorization()
        { [weak self] (status:PHAuthorizationStatus) in
            
            if status == PHAuthorizationStatus.authorized
            {
                self?.authorized()
            }
            else
            {
                self?.authDenied()
            }
        }
    }
    
    private func authDenied()
    {
        let message:String = String.localizedModel(key:"MSourceVideo_authDenied")
        VAlert.messageFail(message:message)
    }
    
    private func authorized()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.loadVideos()
        }
    }
}
