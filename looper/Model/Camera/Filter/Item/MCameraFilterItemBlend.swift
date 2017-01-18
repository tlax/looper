import UIKit

class MCameraFilterItemBlend:MCameraFilterItem
{
    override init()
    {
        let title:String = NSLocalizedString("MCameraFilterItemBlend_title", comment:"")
        let viewTitle:String = NSLocalizedString("MCameraFilterItemBlend_viewTitle", comment:"")
        let image:UIImage = #imageLiteral(resourceName: "assetFilterBlender")
        
        super.init(title:title, viewTitle:viewTitle, image:image)
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
        
        filteredRecord = blender.blend(
            baseRecord:baseRecord,
            overlays:overlays)
        
        return filteredRecord
    }
}
