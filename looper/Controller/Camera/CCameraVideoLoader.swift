import UIKit
import AVFoundation

class CCameraVideoLoader:CController
{
    private let url:URL
    private weak var viewLoader:VCameraVideoLoader!
    private weak var generator:AVAssetImageGenerator?
    
    init(url:URL)
    {
        self.url = url
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    deinit
    {
        generator?.cancelAllCGImageGeneration()
    }
    
    override func loadView()
    {
        let viewLoader:VCameraVideoLoader = VCameraVideoLoader(controller:self)
        self.viewLoader = viewLoader
        view = viewLoader
    }
    
    //MARK: private
    
    private func timesFor(asset:AVAsset, frames:Int) -> [NSValue]
    {
        var times:[NSValue] = []
        let duration:CMTime = asset.duration
        let seconds:Int = Int(ceil(CMTimeGetSeconds(duration)))
        let secondsFrames:Int = seconds * frames
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
    
    private func asyncRender(frames:Int)
    {
        let asset:AVAsset = AVAsset(url:url)
        let times:[NSValue] = timesFor(asset:asset, frames:frames)
        let generator:AVAssetImageGenerator = AVAssetImageGenerator.init(asset:asset)
        self.generator = generator
        
        generator.generateCGImagesAsynchronously(forTimes:times)
        { (
            requestTime:CMTime,
            image:CGImage?,
            actualTime:CMTime,
            result:AVAssetImageGeneratorResult,
            error:Error?) in

            if let error:Error = error
            {
                print(error)
                return
            }
            
            print("image")
        }
    }
    
    //MARK: public
    
    func back()
    {
        parentController.dismissAnimateOver(completion:nil)
    }
    
    func next()
    {
        viewLoader.block()
        
        let frames:Int = viewLoader.viewFrames.frames()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncRender(frames:frames)
        }
    }
}
