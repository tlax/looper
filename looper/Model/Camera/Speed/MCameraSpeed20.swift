import Foundation

class MCameraSpeed20:MCameraSpeed
{
    private let kFramesPerSecond:TimeInterval = 20
    
    init()
    {
        super.init(framesPerSecond:kFramesPerSecond)
    }
}
