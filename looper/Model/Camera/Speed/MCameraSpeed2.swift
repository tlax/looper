import Foundation

class MCameraSpeed2:MCameraSpeed
{
    private let kFramesPerSecond:TimeInterval = 2
    
    override init()
    {
        super.init(framesPerSecond:kFramesPerSecond)
    }
}
