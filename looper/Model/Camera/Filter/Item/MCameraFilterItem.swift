import UIKit

class MCameraFilterItem
{
    let title:String
    let viewTitle:String
    let image:UIImage
    
    init(title:String, viewTitle:String, image:UIImage)
    {
        self.title = title
        self.viewTitle = viewTitle
        self.image = image
    }
    
    //MARK: public
    
    func recordItems() -> [MCameraFilterSelectorItem]
    {
        var items:[MCameraFilterSelectorItem] = []
        
        if let activeRecords:[MCameraRecord] = MSession.sharedInstance.camera?.activeRecords
        {
            for activeRecord:MCameraRecord in activeRecords
            {
                let itemRecord:MCameraFilterSelectorItemRecord = MCameraFilterSelectorItemRecord(
                    record:activeRecord)
                items.append(itemRecord)
            }
        }
        
        return items
    }
    
    func selected(
        filterSelectedItem:MCameraFilterSelectorItem,
        controller:CCameraFilterSelector)
    {
    }
    
    func selectorModel() -> MCameraFilterSelector
    {
        let items:[MCameraFilterSelectorItem] = recordItems()
        let model:MCameraFilterSelector = MCameraFilterSelector(items:items)
        
        return model
    }
    
    func waterMark(original:MCameraRecord) -> MCameraRecord
    {
        guard
        
            let watermark:Bool = MSession.sharedInstance.settings?.watermark
        
        else
        {
            return original
        }
        
        let markedRecord:MCameraRecord
        
        if watermark
        {
            markedRecord = original
        }
        else
        {
            guard
            
                let waterMarker:MCameraFilterProcessorWatermark = MCameraFilterProcessorWatermark()
            
            else
            {
                markedRecord = MCameraRecord()
                
                return markedRecord
            }
            
            markedRecord = waterMarker.addWatermark(original:original)
        }
        
        return markedRecord
    }
}
