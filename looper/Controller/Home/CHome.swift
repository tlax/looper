import UIKit
import ImageIO
import MobileCoreServices

class CHome:CController
{
    weak var viewHome:VHome!
    let modelImage:MHomeImage
    private let kFilename:String = "looper.gif"
    private let kLoopCount:Int = 0
    
    override init()
    {
        modelImage = MHomeImage()
        
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func loadView()
    {
        let viewHome:VHome = VHome(controller:self)
        self.viewHome = viewHome
        view = viewHome
    }
    
    //MARK: private
    
    private func asyncAnimate()
    {
        guard
            
            let modelGenerated:MHomeImageSequenceGenerated = modelImage.renderedSequence
            
        else
        {
            return
        }
        
        var images:[UIImage] = []
        
        for itemGenerated:MHomeImageSequenceItem in modelGenerated.items
        {
            let image:UIImage = itemGenerated.image
            images.append(image)
        }
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewHome.viewDisplay.animateImages(images:images)
            MSession.sharedInstance.state = MSession.State.playing
        }
    }
    
    //MARK: public
    
    func returnToHome()
    {
        viewHome.returnToHome()
        parentController.changeBar(barHidden:false)
        modelImage.generateSequence()
    }
    
    func animate()
    {
        viewHome.viewTimeline.clearSelection()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncAnimate()
        }
    }
    
    func stopAnimation()
    {
        viewHome.viewDisplay.stopAnimation()
        MSession.sharedInstance.state = MSession.State.standBy
    }
    
    func share()
    {
        let directoryUrl:URL = URL(fileURLWithPath:NSTemporaryDirectory())
        let fileUrl:URL = directoryUrl.appendingPathComponent(kFilename)
        
        guard
            
            let generated:MHomeImageSequenceGenerated = modelImage.renderedSequence
            
        else
        {
            return
        }
        
        let totalItems:Int = generated.items.count
        
        guard
            
            let destination:CGImageDestination = CGImageDestinationCreateWithURL(
                fileUrl as CFURL,
                kUTTypeGIF,
                totalItems,
                nil)
            
        else
        {
            return
        }
        
        let timeInterval:TimeInterval = viewHome.viewPlayer.viewTimer.viewSlider.currentTime
        let timePerItem:TimeInterval = timeInterval / TimeInterval(totalItems)
        
        let destinationPropertiesRaw:[String:Any] = [
            kCGImagePropertyGIFDictionary as String:[
                kCGImagePropertyGIFLoopCount as String:kLoopCount]]
        let gifPropertiesRaw:[String:Any] = [
            kCGImagePropertyGIFDictionary as String:[
                kCGImagePropertyGIFDelayTime as String:timePerItem]]
        
        let destinationProperties:CFDictionary = destinationPropertiesRaw as CFDictionary
        let gifProperties:CFDictionary = gifPropertiesRaw as CFDictionary
        
        CGImageDestinationSetProperties(
            destination,
            destinationProperties)
        
        for item:MHomeImageSequenceItem in generated.items
        {
            guard
                
                let cgImage:CGImage = item.image.cgImage
            
            else
            {
                continue
            }
            
            CGImageDestinationAddImage(
                destination,
                cgImage,
                gifProperties)
        }
        
        CGImageDestinationFinalize(destination)
        
        let activity:UIActivityViewController = UIActivityViewController(
            activityItems:[fileUrl],
            applicationActivities:nil)
        
        if activity.popoverPresentationController != nil
        {
            activity.popoverPresentationController!.sourceView = viewHome
            activity.popoverPresentationController!.sourceRect = CGRect.zero
            activity.popoverPresentationController!.permittedArrowDirections = UIPopoverArrowDirection.up
        }
        
        present(activity, animated:true)
    }
}
