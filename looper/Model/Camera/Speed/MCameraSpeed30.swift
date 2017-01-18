import Foundation

class MCameraSpeed30:MCameraSpeed
{
    private let kFramesPerSecond:TimeInterval = 30
    
    init()
    {
        super.init(framesPerSecond:kFramesPerSecond)
    }
}
