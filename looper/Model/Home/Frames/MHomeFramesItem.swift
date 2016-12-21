import Foundation

class MHomeFramesItem
{
    let timeInterval:TimeInterval
    let name:String
    
    init(timeInterval:TimeInterval, name:String)
    {
        self.timeInterval = timeInterval
        self.name = name
    }
    
    init()
    {
        fatalError()
    }
}
