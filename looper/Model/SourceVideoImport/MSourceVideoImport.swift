import Foundation
import AVFoundation

class MSourceVideoImport:Model
{
    private(set) weak var item:MSourceVideoItem!
    private(set) var framesPerSecond:Int
    
    required init()
    {
        framesPerSecond = 0
        super.init()
    }
    
    //MARK: private
    
    private func asyncImportVideo()
    {
        
    }
    
    private func timesArray(duration:CMTime, frames:Int) -> [NSValue]
    {
        var times:[NSValue] = []
        let seconds:Float64 = ceil(CMTimeGetSeconds(duration))
        let secondsInt:Int = Int(seconds)
        let secondsFrames:Int = secondsInt * frames
        let timeScale:CMTimeScale = CMTimeScale(frames)
        
        for secondsFrame:Int in 0 ..< secondsFrames
        {
            let secondsFrameDouble:Double = Double(secondsFrame)
            let time:CMTime = CMTime(
                seconds:secondsFrameDouble,
                preferredTimescale:timeScale)
            let value:NSValue = NSValue(time:time)
            
            times.append(value)
        }
        
        return times
    }
    
    //MARK: public
    
    func config(item:MSourceVideoItem, framesPerSecond:Int)
    {
        self.item = item
        self.framesPerSecond = framesPerSecond
    }
    
    func importVideo()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncImportVideo()
        }
    }
}
