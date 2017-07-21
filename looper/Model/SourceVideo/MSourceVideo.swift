import UIKit
import Photos

class MSourceVideo:Model
{
    private(set) var items:[MSourceVideoItem]
    private weak var cachingManager:PHCachingImageManager?
    private var requestOptions:PHImageRequestOptions?
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
        requestOptions = MSourceVideo.factoryRequestOptions()
        let cachingManager:PHCachingImageManager = PHCachingImageManager()
        self.cachingManager = cachingManager
        
        let countResults:Int = fetchResults.count
        var assets:[PHAsset] = []
        
        for indexResult:Int in 0 ..< countResults
        {
            let asset:PHAsset = fetchResults[indexResult]
            let item:MSourceVideoItem = MSourceVideoItem(
                asset:asset,
                cachingManager:cachingManager,
                requestOptions:requestOptions,
                previewSize:previewSize)
            
            items.append(item)
            assets.append(asset)
        }
        
        cacheAssets(assets:assets)
    }
    
    private func cacheAssets(assets:[PHAsset])
    {
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
