import UIKit

extension MCreateItem
{
    class func factoryFrames(images:[CGImage]) -> [MCreateItemFrame]
    {
        var frames:[MCreateItemFrame] = []
        
        for image:CGImage in images
        {
            let item:MCreateItemFrame = MCreateItemFrame(
                image:image)
            frames.append(item)
        }
        
        return frames
    }
}
