import UIKit

class MCameraFilterItemBlend:MCameraFilterItem
{
    init()
    {
        let title:String = NSLocalizedString("MCameraFilterItemBlend_title", comment:"")
        let viewTitle:String = NSLocalizedString("MCameraFilterItemBlend_viewTitle", comment:"")
        let image:UIImage = #imageLiteral(resourceName: "assetFilterBlender")
        
        super.init(title:title, viewTitle:viewTitle, image:image)
    }
    
    override func selectorModel() -> MCameraFilterSelector
    {
        var items:[MCameraFilterSelectorItem] = []
        
        let itemBlack:MCameraFilterSelectorItemColor = MCameraFilterSelectorItemColor(
            color:UIColor.black)
        let itemWhite:MCameraFilterSelectorItemColor = MCameraFilterSelectorItemColor(
            color:UIColor.white)
        
        items.append(itemBlack)
        items.append(itemWhite)
        
        if let activeRecords:[MCameraRecord] = MSession.sharedInstance.camera?.activeRecords
        {
            for activeRecord:[MCameraRecord] in activeRecords
            {
                let itemRecord:MCameraFilterSelectorItemRecord = MCameraFilterSelectorItemRecord(
                    record:activeRecord)
                items.append(itemRecord)
            }
        }
        
        let model:MCameraFilterSelector = MCameraFilterSelector(items:items)
        
        return model
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
