import Foundation

class MCameraRecord
{
    var items:[MCameraRecordItem]
    let speed:MCameraSpeed
    
    init(speed:MCameraSpeed)
    {
        items = []
        self.speed = speed
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
                    active = MCameraRecord()
                }
                
                active!.items.append(item)
            }
        }
        
        return active
    }
}
