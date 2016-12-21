import Foundation

class MHomeFramesItem1:MHomeFramesItem
{
    private let kFramesPerSecond:TimeInterval = 1
    
    override init()
    {
        let timeInterval:TimeInterval = 1 / kFramesPerSecond
        let name:String = "\(Int(kFramesPerSecond))"
        
        super.init(
            timeInterval:timeInterval,
            name:name)
    }
    
    override init(timeInterval:TimeInterval, name:String)
    {
        fatalError()
    }
}
