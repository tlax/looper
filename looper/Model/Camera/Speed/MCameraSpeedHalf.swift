import Foundation

class MCameraSpeedHalf:MCameraSpeed
{
    private let kFramesPerSecond:TimeInterval = 0.5
    
    override init()
    {
        super.init(framesPerSecond:kFramesPerSecond)
    }
    
    override init(framesPerSecond:TimeInterval)
    {
        fatalError()
    }
}
