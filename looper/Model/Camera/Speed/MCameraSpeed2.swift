import Foundation

class MCameraSpeed2:MCameraSpeed
{
    private let kFramesPerSecond:TimeInterval = 2
    
    init()
    {
        super.init(framesPerSecond:kFramesPerSecond)
    }
}
