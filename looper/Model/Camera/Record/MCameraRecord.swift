import UIKit

class MCameraRecord
{
    var items:[MCameraRecordItem]
    var size:Int?
    
    init()
    {
        items = []
    }
    
    //MARK: public
    
    func isActive() -> Bool
    {
        for item:MCameraRecordItem in items
        {
            if item.active
            {
                return true
            }
        }
        
        return false
    }
    
    func computeSize()
    {
        for item:MCameraRecordItem in items
        {
            let image:UIImage = item.image
            let data:datum
        }
    }
}
