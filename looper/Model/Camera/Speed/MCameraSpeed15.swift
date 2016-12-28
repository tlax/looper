import Foundation

class MCameraSpeed15:MCameraSpeed
{
    private let kFramesPerSecond:TimeInterval = 15
    
    override init()
    {
        super.init(framesPerSecond:kFramesPerSecond)
    }
    
    override init(framesPerSecond:TimeInterval)
    {
        fatalError()
    }
}
