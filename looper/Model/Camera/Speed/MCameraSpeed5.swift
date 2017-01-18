import Foundation

class MCameraSpeed5:MCameraSpeed
{
    private let kFramesPerSecond:TimeInterval = 5
    
    init()
    {
        super.init(framesPerSecond:kFramesPerSecond)
    }
}
