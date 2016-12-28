import UIKit
import AVFoundation

class CCameraShoot:CController
{
    var recording:Bool
    weak var model:MCamera!
    private weak var viewCamera:VCameraShoot!
    private weak var captureSession:AVCaptureSession?
    private weak var captureOutput:AVCaptureStillImageOutput?
    private weak var captureDeviceInput:AVCaptureDeviceInput?
    private weak var timer:Timer?
    private var devicePosition:AVCaptureDevicePosition
    private let queue:DispatchQueue
    private let kMediaType:String = AVMediaTypeVideo
    private let kSessionPreset:String = AVCaptureSessionPreset640x480
    private let kVideoGravity:String = AVLayerVideoGravityResizeAspect
    private let kVideoCodec:String = AVVideoCodecJPEG
    private let kQueueLabel:String = "cameraQueue"
    
    init(model:MCamera)
    {
        recording = false
        devicePosition = AVCaptureDevicePosition.front
        queue = DispatchQueue(
            label:kQueueLabel,
            qos:DispatchQoS.background,
            attributes:DispatchQueue.Attributes(),
            autoreleaseFrequency:DispatchQueue.AutoreleaseFrequency.inherit,
            target:DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
        
        self.model = model
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    deinit
    {
        timer?.invalidate()
        cleanSession()
    }
    
    override func loadView()
    {
        let viewCamera:VCameraShoot = VCameraShoot(controller:self)
        self.viewCamera = viewCamera
        view = viewCamera
    }
    
    override func viewWillAppear(_ animated:Bool)
    {
        super.viewWillAppear(animated)
        parentController.changeBar(barHidden:true)
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        if captureSession == nil
        {
            askAuthorization()
        }
    }
    
    func recordingTick(sender timer:Timer)
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
                
                let model:MCameraRaw = self?.model.raw,
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
        
        viewCamera.viewProcess.update()
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
                VAlert.message(message:
                    NSLocalizedString("CCameraShoot_noAuth", comment:""))
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
            
            self?.viewCamera.viewPreview.addPreviewLayer(
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
                    continue
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
            VAlert.message(message:
                NSLocalizedString("CCameraShoot_errorCaptureDevice", comment:""))
            
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
        sessionStarted()
    }
    
    private func sessionStarted()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewCamera.viewMenu.activateButtons()
        }
    }
    
    //MARK: public
    
    func back()
    {
        timer?.invalidate()
        parentController.changeBar(barHidden:false)
        parentController.pop(deltaX:0, deltaY:-1)
        
//        if buttonTrigger.active
//        {
//            controller.viewHome.viewControl.viewCamera?.actionTrigger(
//                activate:false)
//        }
//        
//        controller.viewHome.viewControl.viewCamera?.layoutTickerHeight = nil
//        controller.returnToHome()
    }
    
    func reverseCamera()
    {
        queue.async
        { [weak self] in
            
            self?.cleanSession()
            
            guard
            
                let currentDevicePosition:AVCaptureDevicePosition = self?.devicePosition
        
            else
            {
                return
            }
            
            switch currentDevicePosition
            {
                case AVCaptureDevicePosition.back,
                     AVCaptureDevicePosition.unspecified:
                    
                    self?.devicePosition = AVCaptureDevicePosition.front
                    
                    break
                    
                case AVCaptureDevicePosition.front:
                    
                    self?.devicePosition = AVCaptureDevicePosition.back
                    
                    break
            }
            
            self?.startSession()
        }
    }
    
    func startRecording()
    {
        if model.raw == nil
        {
            timer?.invalidate()
            
            let modelSpeed:MCameraSpeed = model.currentSpeedModel()
            let speed:TimeInterval = modelSpeed.timeInterval
            model.raw = MCameraRaw()
            
            timer = Timer.scheduledTimer(
                timeInterval:speed,
                target:self,
                selector:#selector(recordingTick(sender:)),
                userInfo:nil,
                repeats:true)
            
            viewCamera.startRecording()
        }
    }
    
    func stopRecording()
    {
        timer?.invalidate()
        /*
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
        */
        viewCamera.stopRecording()
    }
}
