import Foundation

class MHomeFramesItem60:MHomeFramesItem
{
    private let kFramesPerSecond:TimeInterval = 60
    
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
