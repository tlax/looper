import UIKit

class MCameraFilterItem
{
    let title:String
    let image:UIImage
    
    init(title:String, image:UIImage)
    {
        self.title = title
        self.image = image
    }
    
    init()
    {
        fatalError()
    }
    
    //MARK: public
    
    func processController() -> CController?
    {
        return nil
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
