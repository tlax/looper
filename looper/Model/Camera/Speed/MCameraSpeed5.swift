import Foundation

class MCameraSpeed5:MCameraSpeed
{
    private let kFramesPerSecond:TimeInterval = 5
    
    override init()
    {
        super.init(framesPerSecond:kFramesPerSecond)
    }
}
