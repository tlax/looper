import Foundation

class MHomeFramesItem20:MHomeFramesItem
{
    private let kFramesPerSecond:TimeInterval = 20
    
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
