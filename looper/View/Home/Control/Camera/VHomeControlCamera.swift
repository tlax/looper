import UIKit
import AVFoundation

class VHomeControlCamera:UIView
{
    weak var viewMenu:VHomeControlCameraMenu!
    weak var viewTicker:VHomeControlCameraTicker!
    weak var layoutTickerHeight:NSLayoutConstraint?
    private(set) var model:MHomeImageSequenceRaw?
    private weak var controller:CHome!
    private weak var captureSession:AVCaptureSession?
    private weak var captureOutput:AVCaptureStillImageOutput?
    private weak var captureDeviceInput:AVCaptureDeviceInput?
    private weak var viewPreview:VHomeControlCameraPreview!
    private weak var layoutPreviewHeight:NSLayoutConstraint!
    private weak var timer:Timer?
    private var devicePosition:AVCaptureDevicePosition
    private let queue:DispatchQueue
    private let kMediaType:String = AVMediaTypeVideo
    private let kSessionPreset:String = AVCaptureSessionPreset640x480
    private let kVideoGravity:String = AVLayerVideoGravityResizeAspect
    private let kVideoCodec:String = AVVideoCodecJPEG
    private let kQueueLabel:String = "cameraQueue"
    private let kAskAuthAfter:TimeInterval = 0.5
    private let kMenuHeight:CGFloat = 90
    
    init(controller:CHome)
    {
        devicePosition = AVCaptureDevicePosition.back
        
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
        
        let viewMenu:VHomeControlCameraMenu = VHomeControlCameraMenu(
            controller:controller)
        self.viewMenu = viewMenu
        
        let viewTicker:VHomeControlCameraTicker = VHomeControlCameraTicker(
            controller:controller)
        self.viewTicker = viewTicker
        
        addSubview(viewPreview)
        addSubview(viewMenu)
        addSubview(viewTicker)
        
        layoutPreviewHeight = NSLayoutConstraint.height(
            view:viewPreview)
        let layoutPreviewTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:viewPreview,
            toView:self)
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
        
        let layoutTickerTop:NSLayoutConstraint = NSLayoutConstraint.topToBottom(
            view:viewTicker,
            toView:viewPreview)
        layoutTickerHeight = NSLayoutConstraint.height(
            view:viewTicker)
        let layoutTickerLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewTicker,
            toView:self)
        let layoutTickerRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:viewTicker,
            toView:self)
        
        addConstraints([
            layoutPreviewHeight,
            layoutPreviewTop,
            layoutPreviewLeft,
            layoutPreviewRight,
            layoutMenuHeight,
            layoutMenuBottom,
            layoutMenuLeft,
            layoutMenuRight,
            layoutTickerTop,
            layoutTickerHeight!,
            layoutTickerLeft,
            layoutTickerRight])
        
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
    
    deinit
    {
        cleanSession()
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let height:CGFloat = bounds.maxY
        let previewHeight:CGFloat
        let tickerHeight:CGFloat
        
        if width < height
        {
            previewHeight = width
            tickerHeight = height - (previewHeight + kMenuHeight)
        }
        else
        {
            previewHeight = height - kMenuHeight
            tickerHeight = 0
        }
        
        if previewHeight >= 0
        {
            layoutPreviewHeight.constant = previewHeight
        }
        
        if tickerHeight >= 0
        {
            layoutTickerHeight?.constant = tickerHeight
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
            
                let model:MHomeImageSequenceRaw = self?.model,
                let devicePosition:AVCaptureDevicePosition = self?.devicePosition,
                let buffer:CMSampleBuffer = sampleBuffer,
                let data:Data = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(
                    buffer),
                let image:UIImage = UIImage(data:data)
            
            else
            {
                return
            }
            
            let storeImage:UIImage
            
            if devicePosition == AVCaptureDevicePosition.front
            {
                guard
                    
                    let cgImage:CGImage = image.cgImage
                
                else
                {
                    return
                }
                
                storeImage = UIImage(
                    cgImage:cgImage,
                    scale:image.scale,
                    orientation:UIImageOrientation.leftMirrored)
            }
            else
            {
                storeImage = image
            }
            
            model.add(image:storeImage)
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
                    
                    self?.startPreview()
                }
            }
            else
            {
                VAlert.message(
                    message:NSLocalizedString("VHomeControlCamera_noAuth", comment:""))
            }
        }
    }
    
    private func startPreview()
    {
        let captureSession:AVCaptureSession = AVCaptureSession()
        captureSession.sessionPreset = kSessionPreset
        self.captureSession = captureSession
        
        let videoPreviewLayer:AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(
            session:captureSession)
        videoPreviewLayer.videoGravity = kVideoGravity
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewPreview.addPreviewLayer(
                previewLayer:videoPreviewLayer)
        }
        
        startSession()
    }
    
    private func cleanSession()
    {
        captureSession?.stopRunning()
        captureSession?.removeInput(captureDeviceInput)
        captureSession?.removeOutput(captureOutput)
    }
    
    private func startSession()
    {
        var captureDevice:AVCaptureDevice?
        
        if #available(iOS 10.0, *)
        {
            captureDevice = AVCaptureDevice.defaultDevice(
                withDeviceType:AVCaptureDeviceType.builtInWideAngleCamera,
                mediaType:kMediaType,
                position:devicePosition)
        }
        else
        {
            let devices:[Any] = AVCaptureDevice.devices(
                withMediaType:kMediaType)
            
            for device:Any in devices
            {
                guard
                
                    let capture:AVCaptureDevice = device as? AVCaptureDevice
                
                else
                {
                    return
                }
                
                if capture.position == devicePosition
                {
                    captureDevice = capture
                    
                    break
                }
            }
        }
        
        guard
            
            let foundCaptureDevice:AVCaptureDevice = captureDevice
        
        else
        {
            let error:String = NSLocalizedString(
                "VHomeControlCamera_errorCaptureDevice", comment:"")
            VAlert.message(message:error)
            
            return
        }
        
        let tryCaptureDeviceInput:AVCaptureDeviceInput?
        
        do
        {
            try tryCaptureDeviceInput = AVCaptureDeviceInput(
                device:foundCaptureDevice)
        }
        catch let error
        {
            tryCaptureDeviceInput = nil
            VAlert.message(message:error.localizedDescription)
        }
        
        guard
            
            let captureDeviceInput:AVCaptureDeviceInput = tryCaptureDeviceInput
            
        else
        {
            return
        }
        
        self.captureDeviceInput = captureDeviceInput
        captureSession?.addInput(captureDeviceInput)
        
        let captureOutput:AVCaptureStillImageOutput = AVCaptureStillImageOutput()
        captureOutput.outputSettings = [AVVideoCodecKey:kVideoCodec]
        self.captureOutput = captureOutput
        
        captureSession?.addOutput(captureOutput)
        captureSession?.startRunning()
    }
    
    //MARK: public
    
    func reverseCamera()
    {
        cleanSession()
        
        switch devicePosition
        {
            case AVCaptureDevicePosition.back,
                 AVCaptureDevicePosition.unspecified:
            
                devicePosition = AVCaptureDevicePosition.front
                
                break
            
            case AVCaptureDevicePosition.front:
            
                devicePosition = AVCaptureDevicePosition.back
                
                break
        }
        
        startSession()
    }
    
    func actionTrigger(activate:Bool)
    {
        timer?.invalidate()
        
        if activate
        {
            model = MHomeImageSequenceRaw()
            
            guard
                
                let triggerInterval:TimeInterval = controller.viewHome.viewControl.viewCamera?.viewTicker.viewFrames.timeInterval()
            
            else
            {
                return
            }
            
            timer = Timer.scheduledTimer(
                timeInterval:triggerInterval,
                target:self,
                selector:#selector(self.asyncActionTrigger),
                userInfo:nil,
                repeats:true)
            
            viewTicker.viewProcess.start()
            viewTicker.viewFrames.blockButtons()
        }
        else
        {
            viewTicker.viewProcess.clean()
            viewTicker.viewFrames.releaseButtons()
            
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                guard
                    
                    let model:MHomeImageSequenceRaw = self?.model
                    
                else
                {
                    return
                }
                
                self?.model = nil
                self?.controller.modelImage.add(sequence:model)
            }
        }
    }
}
