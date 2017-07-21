import Foundation
import Photos

class MSourceVideo:Model
{
    private(set) var items:[MSourceVideoItem]
    
    required init()
    {
        items = []
        
        super.init()
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
    
    private func loadVideos()
    {
        guard
            
            let fetchResults:PHFetchResult<PHAsset> = MSourceVideo.factoryFetch()
        
        else
        {
            libraryError()
            
            return
        }
        
        let countResults:Int = fetchResults.count
        
        for indexResult:Int in 0 ..< countResults
        {
            let fetchResult:PHAsset = fetchResults[indexResult]
            
        }
        
        imagesLoaded()
    }
    
    private func libraryError()
    {
        let message:String = String.localizedModel(key:"MSourceVideo_libraryError")
        VAlert.messageFail(message:message)
    }
    
    private func imagesLoaded()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewPicker.imagesLoaded()
        }
    }
    
    //MARK: public
    
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
}
