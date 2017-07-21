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
    
    private func libraryError()
    {
        let message:String = String.localizedModel(key:"MSourceVideo_libraryError")
        VAlert.messageFail(message:message)
    }
    
    private func loadVideos(fetchResults:PHFetchResult<PHAsset>)
    {
        let countResults:Int = fetchResults.count
        
        for indexResult:Int in 0 ..< countResults
        {
            let fetchResult:PHAsset = fetchResults[indexResult]
            
        }
        
        delegate?.modelRefresh()
    }
    
    //MARK: public

    private func loadVideos()
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
