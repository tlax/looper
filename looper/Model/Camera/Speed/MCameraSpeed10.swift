import Foundation

class MCameraSpeed10:MCameraSpeed
{
    private let kFramesPerSecond:TimeInterval = 10
    
    init()
    {
        super.init(framesPerSecond:kFramesPerSecond)
    }
}
