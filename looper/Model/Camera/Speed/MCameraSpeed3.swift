import Foundation

class MCameraSpeed3:MCameraSpeed
{
    private let kFramesPerSecond:TimeInterval = 3
    
    override init()
    {
        super.init(framesPerSecond:kFramesPerSecond)
    }
    
    override init(framesPerSecond:TimeInterval)
    {
        fatalError()
    }
}
