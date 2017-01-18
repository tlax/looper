import Foundation

class MCameraSpeed15:MCameraSpeed
{
    private let kFramesPerSecond:TimeInterval = 15
    
    init()
    {
        super.init(framesPerSecond:kFramesPerSecond)
    }
}
