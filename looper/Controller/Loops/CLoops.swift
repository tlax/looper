import UIKit
import ImageIO
import MobileCoreServices

class CLoops:CController
{
    weak var viewLoops:VLoops!
    let model:MLoops
    private let kFilename:String = "looper.gif"
    private let kLoopCount:Int = 0

    override init()
    {
        model = MLoops()
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidLoad()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
         
            self?.loadFromDB()
        }
    }
    
    override func loadView()
    {
        let viewLoops:VLoops = VLoops(controller:self)
        self.viewLoops = viewLoops
        view = viewLoops
    }
    
    //MARK: private
    
    private func loadFromDB()
    {
        model.loadFromDb
        {
            DispatchQueue.main.async
            { [weak self] in
            
                self?.loadedFromDB()
            }
        }
    }
    
    private func loadedFromDB()
    {
        viewLoops.stopLoading()
    }
    
    private func confirmDelete(model:MLoopsItem)
    {
        model.delete()
        loadFromDB()
    }
    
    private func asyncShare(model:MLoopsItem)
    {
        let images:[UIImage] = model.images.imageLists()
        let directoryUrl:URL = URL(fileURLWithPath:NSTemporaryDirectory())
        let fileUrl:URL = directoryUrl.appendingPathComponent(kFilename)
        
        let totalImages:Int = images.count
        
        guard
            
            let destination:CGImageDestination = CGImageDestinationCreateWithURL(
                fileUrl as CFURL,
                kUTTypeGIF,
                totalImages,
                nil)
            
        else
        {
            return
        }
        
        let duration:TimeInterval = model.loop.duration
        let timePerItem:TimeInterval = duration / TimeInterval(totalImages)
        
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
        
        for image:UIImage in images
        {
            guard
                
                let cgImage:CGImage = image.cgImage
                
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
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.finishShare(gif:fileUrl)
        }
    }
    
    private func finishShare(gif:URL)
    {
        let activity:UIActivityViewController = UIActivityViewController(
            activityItems:[gif],
            applicationActivities:nil)
        
        if activity.popoverPresentationController != nil
        {
            activity.popoverPresentationController!.sourceView = viewLoops
            activity.popoverPresentationController!.sourceRect = CGRect.zero
            activity.popoverPresentationController!.permittedArrowDirections = UIPopoverArrowDirection.up
        }
        
        present(
            activity,
            animated:true)
        { [weak self] in
            
            self?.viewLoops.stopLoading()
        }
    }
    
    //MARK: public
    
    func delete(model:MLoopsItem)
    {
        let alert:UIAlertController = UIAlertController(
            title:
            NSLocalizedString("CLoops_alertTitle", comment:""),
            message:nil,
            preferredStyle:UIAlertControllerStyle.actionSheet)
        
        let actionCancel:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CLoops_alertCancel", comment:""),
            style:
            UIAlertActionStyle.cancel)
        
        let actionDelete:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CLoops_alertDelete", comment:""),
            style:
            UIAlertActionStyle.destructive)
        { [weak self] (action:UIAlertAction) in
            
            self?.viewLoops.startLoading()
            
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                self?.confirmDelete(model:model)
            }
        }
        
        alert.addAction(actionDelete)
        alert.addAction(actionCancel)
        present(alert, animated:true, completion:nil)
    }
    
    func share(model:MLoopsItem)
    {
        viewLoops.startLoading()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncShare(model:model)
        }
    }
}
