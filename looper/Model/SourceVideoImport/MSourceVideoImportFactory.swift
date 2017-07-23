import UIKit
import AVFoundation

class MSourceVideoImportFactory
{
    private weak var delegate:MSourceVideoImportFactoryDelegate?
    private weak var item:MSourceVideoItem!
    private weak var generator:AVAssetImageGenerator?
    private var avAsset:AVAsset!
    private var images:[CGImage]
    private var times:[[NSValue]]
    private var timesIndex:Int
    private var totalTimes:Int
    private let framesPerSecond:Int
    private let kDelay:TimeInterval = 1
    private let kInitialTimesIndex:Int = -1
    
    init(
        item:MSourceVideoItem,
        framesPerSecond:Int,
        delegate:MSourceVideoImportFactoryDelegate)
    {
        self.item = item
        self.framesPerSecond = framesPerSecond
        self.delegate = delegate
        images = []
        times = []
        timesIndex = kInitialTimesIndex
        totalTimes = 0
        
        item.requestAvAsset
        { [weak self] (avAsset:AVAsset?) in
            
            guard
                
                let avAsset:AVAsset = avAsset
                
            else
            {
                self?.delegate?.importError()
                
                return
            }
            
            self?.assetGot(avAsset:avAsset)
        }
    }
    
    deinit
    {
        generator?.cancelAllCGImageGeneration()
    }
    
    private func timesArray(duration:CMTime, frames:Int) -> [[NSValue]]
    {
        var times:[[NSValue]] = []
        let seconds:Float64 = floor(CMTimeGetSeconds(duration))
        let secondsInt:Int = Int(seconds)
        let timeScale:CMTimeScale = CMTimeScale(frames)
        
        for second:Int in 0 ..< secondsInt
        {
            var values:[NSValue] = []
            
            for frame:Int in 0 ..< frames
            {
                let secondFrame:Int = second * frame
                let secondsFrameDouble:Double = Double(secondFrame)
                let time:CMTime = CMTime(
                    seconds:secondsFrameDouble,
                    preferredTimescale:timeScale)
                let value:NSValue = NSValue(time:time)
                
                values.append(value)
            }
            
            times.append(values)
        }
        
        return times
    }
    
    private func assetGot(avAsset:AVAsset)
    {
        self.avAsset = avAsset
        times = timesArray(
            duration:avAsset.duration,
            frames:framesPerSecond)
        
        totalTimes = Int(times.count)
        
        recursiveCheck()
    }
    
    private func delayRecursiveImport()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).asyncAfter(
            deadline:DispatchTime.now() + kDelay)
        { [weak self] in
            
            self?.recursiveImport()
        }
    }
    
    private func recursiveImport()
    {
        let times:[NSValue] = self.times[timesIndex]
        let countTimes:Int = times.count
        var received:Int = 0
        
        let generator:AVAssetImageGenerator = AVAssetImageGenerator(
            asset:avAsset)
        self.generator = generator
        
        generator.generateCGImagesAsynchronously(forTimes:times)
        { [weak self] (
            requestTime:CMTime,
            cgImage:CGImage?,
            actualTime:CMTime,
            result:AVAssetImageGeneratorResult,
            error:Error?) in
            
            if error == nil
            {
                if result == AVAssetImageGeneratorResult.succeeded
                {
                    if let cgImage:CGImage = cgImage
                    {
                        self?.images.append(cgImage)
                    }
                }
            }
            
            received += 1
            
            if received == countTimes
            {
                generator.cancelAllCGImageGeneration()
                self?.recursiveCheck()
            }
        }
    }
    
    private func recursiveCheck()
    {
        print(images.count)
        
        timesIndex += 1
        
        if timesIndex >= totalTimes
        {
            delegate?.importImagesReady(images:images)
        }
        else
        {
            let index:CGFloat = CGFloat(timesIndex)
            let total:CGFloat = CGFloat(totalTimes)
            let progress:CGFloat = index / total
            
            delegate?.importProgress(percent:progress)
            delayRecursiveImport()
        }
    }
}
