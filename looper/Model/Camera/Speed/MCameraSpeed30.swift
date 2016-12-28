import Foundation

class MCameraSpeed30:MCameraSpeed
{
    private let kFramesPerSecond:TimeInterval = 30
    
    override init()
    {
        super.init(framesPerSecond:kFramesPerSecond)
    }
    
    override init(framesPerSecond:TimeInterval)
    {
        fatalError()
    }
}
