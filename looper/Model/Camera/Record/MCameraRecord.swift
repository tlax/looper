import Foundation

class MCameraRecord
{
    var items:[MCameraRecordItem]
    
    init()
    {
        items = []
    }
    
    //MARK: public
    
    func activeVersion() -> MCameraRecord?
    {
        var active:MCameraRecord?
        
        for item:MCameraRecordItem in items
        {
            if item.active
            {
                if active == nil
                {
                    active = MCameraRecord(speed:speed)
                }
                
                active!.items.append(item)
            }
        }
        
        return active
    }
}
