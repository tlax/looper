import Foundation

class MCameraSpeed1:MCameraSpeed
{
    private let kFramesPerSecond:TimeInterval = 1
    
    init()
    {
        super.init(framesPerSecond:kFramesPerSecond)
    }
}
