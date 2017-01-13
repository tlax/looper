import Foundation

class MCameraRecordEditable:MCameraRecord
{
    let speed:MCameraSpeed
    
    init(speed:MCameraSpeed)
    {
        self.speed = speed
        
        super.init()
    }
}
