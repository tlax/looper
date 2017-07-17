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
    /*
    private func timesFor(asset:AVAsset) -> [NSValue]
    {
        let duration:CMTime = asset.duration
        let seconds:Float64 = CMTimeGetSeconds(duration)
        
        return generator
    }
    
    private func asyncRender(url:URL)
    {
        let asset:AVAsset = AVAsset(url:url)
        let generator:AVAssetImageGenerator = AVAssetImageGenerator.init(asset:asset)
        self.generator = generator
        
        generator.generateCGImagesAsynchronously(forTimes: [])
        { (<#CMTime#>, <#CGImage?#>, <#CMTime#>, <#AVAssetImageGeneratorResult#>, <#Error?#>) in
            
        }
    }
    
    private func render(url:URL?)
    {
        guard
            
            let url:URL = url
            
        else
        {
            return
        }
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                self?.asyncRender(url:url)
        }
    }*/
}
