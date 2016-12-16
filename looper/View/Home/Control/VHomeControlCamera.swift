import UIKit
import AVFoundation

class VHomeControlCamera:UIView
{
    private weak var controller:CHome!
    private weak var videoPreviewLayer:AVCaptureVideoPreviewLayer?
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
        let captureSession:AVCaptureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSessionPreset352x288
        
        let videoPreviewLayer:AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(
            session:captureSession)
        videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspect
        self.videoPreviewLayer = videoPreviewLayer
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.layer.addSublayer(videoPreviewLayer)
        }
        
        let captureDevice:AVCaptureDevice = AVCaptureDevice.defaultDevice(withMediaType:AVMediaTypeVideo)
        let tryCaptureDeviceInput:AVCaptureDeviceInput?
        let errorString:String?
        
        do
        {
            try tryCaptureDeviceInput = AVCaptureDeviceInput.init(device:captureDevice)
            errorString = nil
        }
        catch let error
        {
            tryCaptureDeviceInput = nil
            errorString = error.localizedDescription
        }
        
        guard
            
            let captureDeviceInput:AVCaptureDeviceInput = tryCaptureDeviceInput
            
        else
        {
            if let error:String = errorString
            {
                VAlert.message(message:error)
            }
            
            return
        }
        
        captureSession.addInput(captureDeviceInput)
        
        let captureOutput:AVCaptureMovieFileOutput = AVCaptureMovieFileOutput()
        captureOutput.setOutputSettings(<#T##outputSettings: [AnyHashable : Any]!##[AnyHashable : Any]!#>, for: <#T##AVCaptureConnection!#>)
        captureSession.addOutput(captureOutput)
        captureSession.startRunning()
    }
}
