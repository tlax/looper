import UIKit
import AVFoundation

class VHomeControlCamera:UIView
{
    private var model:MHomeImageSequenceRaw?
    private weak var controller:CHome!
    private weak var captureOutput:AVCaptureStillImageOutput?
    private weak var viewPreview:VHomeControlCameraPreview!
    private weak var viewMenu:VHomeControlCameraMenu!
    private weak var layoutPreviewHeight:NSLayoutConstraint!
    private weak var timer:Timer?
    private let queue:DispatchQueue
    private let kMediaType:String = AVMediaTypeVideo
    private let kSessionPreset:String = AVCaptureSessionPreset352x288
    private let kVideoGravity:String = AVLayerVideoGravityResizeAspect
    private let kVideoCodec:String = AVVideoCodecJPEG
    private let kQueueLabel:String = "cameraQueue"
    private let kAskAuthAfter:TimeInterval = 0.5
    private let kTriggerInterval:TimeInterval = 1
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
    
    func asyncActionTrigger()
    {
        guard
            
            let connection:AVCaptureConnection = captureOutput?.connection(
                withMediaType:kMediaType)
            
        else
        {
            return
        }
        
        captureOutput?.captureStillImageAsynchronously(
            from:connection)
        { [weak self] (sampleBuffer:CMSampleBuffer?, error:Error?) in
         
            guard
            
                let buffer:CMSampleBuffer = sampleBuffer,
                let data:Data = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(
                    buffer),
                let image:UIImage = UIImage(data:data)
            
            else
            {
                return
            }
            
            self?.model?.add(image:image)
        }
    }
    
    //MARK: private

    private func askAuthorization()
    {
        AVCaptureDevice.requestAccess(forMediaType:kMediaType)
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
                VAlert.message(
                    message:NSLocalizedString("VHomeControlCamera_noAuth", comment:""))
            }
        }
    }
    
    private func startSession()
    {
        let captureSession:AVCaptureSession = AVCaptureSession()
        captureSession.sessionPreset = kSessionPreset
        
        let videoPreviewLayer:AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(
            session:captureSession)
        videoPreviewLayer.videoGravity = kVideoGravity
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewPreview.addPreviewLayer(
                previewLayer:videoPreviewLayer)
        }
        
        let captureDevice:AVCaptureDevice = AVCaptureDevice.defaultDevice(
            withMediaType:kMediaType)
        let tryCaptureDeviceInput:AVCaptureDeviceInput?
        let errorString:String?
        
        do
        {
            try tryCaptureDeviceInput = AVCaptureDeviceInput(device:captureDevice)
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
        
        let captureOutput:AVCaptureStillImageOutput = AVCaptureStillImageOutput()
        captureOutput.outputSettings = [AVVideoCodecKey:kVideoCodec]
        captureSession.addOutput(captureOutput)
        captureSession.startRunning()
        self.captureOutput = captureOutput
    }
    
    //MARK: public
    
    func actionTrigger(activate:Bool)
    {
        timer?.invalidate()
        
        if activate
        {
            model = MHomeImageSequenceRaw()
            
            timer = Timer.scheduledTimer(
                timeInterval:kTriggerInterval,
                target:self,
                selector:#selector(self.asyncActionTrigger),
                userInfo:nil,
                repeats:true)
        }
        else
        {
            guard
                
                let model:MHomeImageSequenceRaw = self.model
            
            else
            {
                return
            }
            
            print(model.items.count)
            controller.modelImage.add(sequence:model)
        }
    }
}
