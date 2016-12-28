import Foundation

class MCameraSpeed
{
    let timeInterval:TimeInterval
    let name:String
    
    init(framesPerSecond:TimeInterval)
    {
        timeInterval = 1 / framesPerSecond
        name = "\(Int(framesPerSecond))"
    }
    
    init()
    {
        fatalError()
    }
}
