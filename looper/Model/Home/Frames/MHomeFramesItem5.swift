import Foundation

class MHomeFramesItem5:MHomeFramesItem
{
    private let kFramesPerSecond:TimeInterval = 5
    
    override init()
    {
        let timeInterval:TimeInterval = 1 / kFramesPerSecond
        let name:String = "\(timeInterval)"
        
        super.init(
            timeInterval:timeInterval,
            name:name)
    }
    
    override init(timeInterval:TimeInterval, name:String)
    {
        fatalError()
    }
}
