import UIKit

class MCreateItem
{
    let frames:[MCreateItemFrame]
    private(set) var duration:TimeInterval
    
    init(images:[CGImage])
    {
        frames = MCreateItem.factoryFrames(images:images)
        duration = 0
    }
    
    //MARK: public
    
    func changeDuration(duration:TimeInterval)
    {
        self.duration = duration
    }
}
