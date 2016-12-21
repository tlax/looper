import Foundation

class MHomeFramesItem30:MHomeFramesItem
{
    private let kFramesPerSecond:TimeInterval = 30
    
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
