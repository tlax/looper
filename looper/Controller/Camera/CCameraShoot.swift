import UIKit
import AVFoundation

class CCameraShoot:CController
{
    var recording:Bool
    private weak var viewCamera:VCameraShoot!
    private weak var model:MCamera?
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
}
