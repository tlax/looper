import UIKit
import Photos

class MSourceVideo:Model
{
    private(set) var items:[MSourceVideoItem]
    private weak var cachingManager:PHCachingImageManager?
    private let previewSize:CGSize
    private let kPreviewSize:CGFloat = 128
    
    required init()
    {
        items = []
        previewSize = CGSize(width:kPreviewSize, height:kPreviewSize)
        
        super.init()
    }
    
    //MARK: private
    
    private func libraryError()
    {
        let message:String = String.localizedModel(key:"MSourceVideo_libraryError")
        VAlert.messageFail(message:message)
    }
    
    private func loadVideos(fetchResults:PHFetchResult<PHAsset>)
    {
        let cachingManager:PHCachingImageManager = PHCachingImageManager()
        self.cachingManager = cachingManager
        
        let countResults:Int = fetchResults.count
        var assets:[PHAsset] = []
        
        for indexResult:Int in 0 ..< countResults
        {
            let asset:PHAsset = fetchResults[indexResult]
            let item:MSourceVideoItem = MSourceVideoItem(asset:asset)
            
            items.append(item)
            assets.append(asset)
        }
        
        cacheAssets(assets:assets)
    }
    
    private func cacheAssets(assets:[PHAsset])
    {
        let requestOptions:PHImageRequestOptions = MSourceVideo.factoryRequestOptions()
        
        cachingManager?.startCachingImages(
            for:assets,
            targetSize:previewSize,
            contentMode:PHImageContentMode.aspectFill,
            options:requestOptions)
        
        delegate?.modelRefresh()
    }
    
    //MARK: public

    func loadVideos()
    {
        guard
            
            let fetchResults:PHFetchResult<PHAsset> = MSourceVideo.factoryFetch()
            
        else
        {
            libraryError()
            
            return
        }
        
        loadVideos(fetchResults:fetchResults)
    }
}
