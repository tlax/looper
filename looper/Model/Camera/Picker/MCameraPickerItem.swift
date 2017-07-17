import UIKit
import Photos

class MCameraPickerItem
{
    var image:UIImage?
    var imageData:Data?
    var photoId:String?
    let asset:PHAsset
    let localId:String
    let creationDate:TimeInterval
    let pixelWidth:Int
    let pixelHeight:Int
    private var requestId:PHImageRequestID?
    private let kTimeZero:TimeInterval = 0
    
    init(asset:PHAsset)
    {
        pixelWidth = asset.pixelWidth
        pixelHeight = asset.pixelHeight
        localId = asset.localIdentifier
        self.asset = asset
        
        let imageSize:CGSize = CGSize(
            width:MCameraPicker.kThumbnailSize,
            height:MCameraPicker.kThumbnailSize)
        
        let requestOptions:PHImageRequestOptions = PHImageRequestOptions()
        requestOptions.resizeMode = PHImageRequestOptionsResizeMode.fast
        requestOptions.isSynchronous = false
        requestOptions.deliveryMode = PHImageRequestOptionsDeliveryMode.fastFormat
        
        if let creationDate:TimeInterval = asset.creationDate?.timeIntervalSince1970
        {
            self.creationDate = creationDate
        }
        else
        {
            self.creationDate = kTimeZero
        }
        
        requestId = PHImageManager.default().requestImage(
            for:asset,
            targetSize:imageSize,
            contentMode:PHImageContentMode.aspectFill,
            options:requestOptions)
        { [weak self] (
            image:UIImage?,
            info:[AnyHashable:Any]?) in
            
            self?.requestId = nil
            self?.image = image
        }
    }
    
    deinit
    {
        if let requestId:PHImageRequestID = requestId
        {
            PHImageManager.default().cancelImageRequest(requestId)
        }
    }
}
