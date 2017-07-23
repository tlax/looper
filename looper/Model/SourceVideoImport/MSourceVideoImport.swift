import Foundation
import AVFoundation

class MSourceVideoImport:Model
{
    private weak var controller:CSourceVideoImport?
    private weak var item:MSourceVideoItem!
    private var framesPerSecond:Int
    
    required init()
    {
        framesPerSecond = 0
        super.init()
    }
    
    //MARK: private
    
    private func asyncImportVideo()
    {
        item.requestAvAsset
        { [weak self] (avAsset:AVAsset?) in
            
            guard
            
                let avAsset:AVAsset = avAsset
            
            else
            {
                self?.errorLoading()
                
                return
            }
            
            self?.errorLoading()
            //self?.assetGot(avAsset:avAsset)
        }
    }
    
    private func assetGot(avAsset:AVAsset)
    {
        
    }
    
    private func errorLoading()
    {
        let error:String = String.localizedModel(key:"MSourceVideoImport_error")
        VAlert.messageFail(message:error)
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.controller?.cancel()
        }
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
    
    func importVideo(controller:CSourceVideoImport)
    {
        self.controller = controller
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncImportVideo()
        }
    }
}
