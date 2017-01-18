import Foundation

class MCameraSpeedHalf:MCameraSpeed
{
    private let kFramesPerSecond:TimeInterval = 0.5
    
    init()
    {
        super.init(framesPerSecond:kFramesPerSecond)
    }
}
