import UIKit
import Photos

class MCameraPickerItem
{
    var image:UIImage?
    let pixelWidth:Int
    let pixelHeight:Int
    let creationDate:TimeInterval
    private var requestId:PHImageRequestID?
    
    init(asset:PHAsset)
    {
        pixelWidth = asset.pixelWidth
        pixelHeight = asset.pixelHeight
        
        let imageSize:CGSize = CGSize(
            width:MCameraPicker.kThumbnailSize,
            height:MCameraPicker.kThumbnailSize)
        
        if let creationDate:TimeInterval = asset.creationDate?.timeIntervalSince1970
        {
            self.creationDate = creationDate
        }
        else
        {
            self.creationDate = 0
        }
        
        let requestOptions:PHImageRequestOptions = PHImageRequestOptions()
        requestOptions.resizeMode = PHImageRequestOptionsResizeMode.fast
        requestOptions.isSynchronous = false
        requestOptions.deliveryMode = PHImageRequestOptionsDeliveryMode.fastFormat
        
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
    
    //MARK: public
    
    func render() -> MCameraRecordItem?
    {
        guard
            
            let image:UIImage = self.image
        
        else
        {
            return nil
        }
        
        let width:CGFloat = image.size.width
        let height:CGFloat = image.size.height
        let minRawSize:CGFloat = min(width, height)
        let minSize:CGFloat = min(minRawSize, MCamera.kImageMaxSize)
        let deltaWidth:CGFloat = width / minSize
        let deltaHeight:CGFloat = height / minSize
        let maxDelta:CGFloat = max(deltaWidth, deltaHeight)
        let width_delta:CGFloat = width / maxDelta
        let height_delta:CGFloat = height / maxDelta
        let remainLeft:CGFloat = width_delta - minSize
        let remainTop:CGFloat = height_delta - minSize
        let marginLeft:CGFloat = remainLeft / -2.0
        let marginTop:CGFloat = remainTop / -2.0
        
        let imageSize:CGSize = CGSize(
            width:minSize,
            height:minSize)
        let drawingRect:CGRect = CGRect(
            x:marginLeft,
            y:marginTop,
            width:width_delta,
            height:height_delta)
        UIGraphicsBeginImageContext(imageSize)
        image.draw(in:drawingRect)
        
        guard
            
            let normalizedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
            
        else
        {
            UIGraphicsEndImageContext()
            
            return nil
        }
        
        UIGraphicsEndImageContext()
        
        let renderedItem:MCameraRecordItem = MCameraRecordItem(
            image:normalizedImage)
        
        return renderedItem
    }
}
