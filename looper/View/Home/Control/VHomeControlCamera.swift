import UIKit
import AVFoundation

class VHomeControlCamera:UIView
{
    private weak var controller:CHome!
    private let queue:DispatchQueue
    private let kQueueLabel:String = "cameraQueue"
    private let kAskAuthAfter:TimeInterval = 0.5
    
    init(controller:CHome)
    {
        queue = DispatchQueue(
            label:kQueueLabel,
            qos:DispatchQoS.background,
            attributes:DispatchQueue.Attributes(),
            autoreleaseFrequency:DispatchQueue.AutoreleaseFrequency.inherit,
            target:DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.gray
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kAskAuthAfter)
        { [weak self] in
            
            self?.askAuthorization()
        }
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: private
    
    private func askAuthorization()
    {
        AVCaptureDevice.requestAccess(forMediaType:AVMediaTypeVideo)
        { [weak self] (granted:Bool) in
            
            if granted
            {
                self?.queue.async
                { [weak self] in
                    
                    self?.startSession()
                }
            }
            else
            {
                VAlert.message(message:NSLocalizedString("VHomeControlCamera_noAuth", comment:""))
            }
        }
    }
    
    private func startSession()
    {
        
    }
}
