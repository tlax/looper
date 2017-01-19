import Foundation

class MCameraSpeed3:MCameraSpeed
{
    private let kFramesPerSecond:TimeInterval = 3
    
    init()
    {
        super.init(framesPerSecond:kFramesPerSecond)
    }
}
