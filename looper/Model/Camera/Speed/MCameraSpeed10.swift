import Foundation

class MCameraSpeed10:MCameraSpeed
{
    private let kFramesPerSecond:TimeInterval = 10
    
    override init()
    {
        super.init(framesPerSecond:kFramesPerSecond)
    }
}
