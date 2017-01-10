import UIKit

class MCameraFilterItemBlend:MCameraFilterItem
{
    override init()
    {
        let title:String = NSLocalizedString("MCameraFilterItemBlend_title", comment:"")
        let image:UIImage = #imageLiteral(resourceName: "assetCameraFilterBlend")
        
        super.init(title:title, image:image)
    }
    
    override init(title:String, image:UIImage)
    {
        fatalError()
    }
    
    override func processController() -> CController?
    {
        let controller:CCameraFilterBlender = CCameraFilterBlender(model:self)
        
        return controller
    }
    
    //MARK: public
    
    func filter(
        baseRecord:MCameraRecord?,
        overlays:[MCameraFilterItemBlendOverlay]) -> MCameraRecord
    {
        let filteredRecord:MCameraRecord
        
        guard
            
            let blender:MCameraFilterProcessorBlender = MCameraFilterProcessorBlender()
            
        else
        {
            filteredRecord = MCameraRecord()
            
            return filteredRecord
        }
        
        markedRecord = waterMarker.addWatermark(original:original)
        
        return filteredRecord
    }
}
