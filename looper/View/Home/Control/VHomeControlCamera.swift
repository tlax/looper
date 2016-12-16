import UIKit
import AVFoundation

class VHomeControlCamera:UIView
{
    private weak var controller:CHome!
    private weak var viewPreview:VHomeControlCameraPreview!
    private weak var viewMenu:VHomeControlCameraMenu!
    private weak var layoutPreviewHeight:NSLayoutConstraint!
    private let queue:DispatchQueue
    private let kQueueLabel:String = "cameraQueue"
    private let kAskAuthAfter:TimeInterval = 0.5
    private let kMenuHeight:CGFloat = 100
    
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
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let viewPreview:VHomeControlCameraPreview = VHomeControlCameraPreview()
        self.viewPreview = viewPreview
        
        let viewMenu:VHomeControlCameraMenu = VHomeControlCameraMenu(controller:controller)
        self.viewMenu = viewMenu
        
        addSubview(viewPreview)
        addSubview(viewMenu)
        
        layoutPreviewHeight = NSLayoutConstraint.height(
            view:viewPreview)
        let layoutPreviewBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToTop(
            view:viewPreview,
            toView:viewMenu)
        let layoutPreviewLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewPreview,
            toView:self)
        let layoutPreviewRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:viewPreview,
            toView:self)
        
        let layoutMenuHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:viewMenu,
            constant:kMenuHeight)
        let layoutMenuBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:viewMenu,
            toView:self)
        let layoutMenuLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewMenu,
            toView:self)
        let layoutMenuRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:viewMenu,
            toView:self)
        
        addConstraints([
            layoutPreviewHeight,
            layoutPreviewBottom,
            layoutPreviewLeft,
            layoutPreviewRight,
            layoutMenuHeight,
            layoutMenuBottom,
            layoutMenuLeft,
            layoutMenuRight])
        
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
    
    override func layoutSubviews()
    {
        let height:CGFloat = bounds.maxY
        let previewHeight:CGFloat = height - kMenuHeight
        
        if previewHeight >= 0
        {
            layoutPreviewHeight.constant = previewHeight
        }
        
        super.layoutSubviews()
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
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewPreview.addPreviewLayer(previewLayer:videoPreviewLayer)
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
        captureSession.addOutput(captureOutput)
        captureSession.startRunning()
    }
}
