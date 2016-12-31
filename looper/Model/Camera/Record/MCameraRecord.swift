import Foundation

class MCameraRecord
{
    var items:[MCameraRecordItem]
    
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
}
