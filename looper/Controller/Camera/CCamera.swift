import UIKit

class CCamera:CController
{
    weak var viewCamera:VCamera!
    private var refreshCamera:Bool
    
    override init()
    {
        refreshCamera = true
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if MSession.sharedInstance.camera == nil
        {
            MSession.sharedInstance.camera = MCamera()
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(notifiedCameraLoading(sender:)),
            name:Notification.cameraLoading,
            object:nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(notifiedCameraLoadFinished(sender:)),
            name:Notification.cameraLoadFinished,
            object:nil)
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        if refreshCamera
        {
            viewCamera.refresh()
        }
    }
    
    override func loadView()
    {
        let viewCamera:VCamera = VCamera(controller:self)
        self.viewCamera = viewCamera
        view = viewCamera
    }
    
    //MARK: notifications
    
    func notifiedCameraLoading(sender notification:Notification)
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewCamera.showLoading()
        }
    }
    
    func notifiedCameraLoadFinished(sender notification:Notification)
    {
        DispatchQueue.main.async
        { [weak self] in
                
            self?.viewCamera.refresh()
        }
    }
    
    //MARK: private
    
    private func confirmTrash(item:MCameraRecord)
    {
        MSession.sharedInstance.camera?.trashRecord(record:item)
        viewCamera.refresh()
    }
    
    private func parseVideo(url:URL?)
    {
        guard
        
            let url:URL = url
        
        else
        {
            return
        }
        
        let controller:CCameraVideoLoader = CCameraVideoLoader(url:url)
        parentController.push(
            controller:controller,
            vertical:CParent.TransitionVertical.fromTop)
    }
    
    //MARK: public
    
    func help()
    {
        let helpCamera:MHelpCamera = MHelpCamera()
        let controllerHelp:CHelp = CHelp(model:helpCamera)
        parentController.push(
            controller:controllerHelp,
            vertical:CParent.TransitionVertical.fromTop)
    }
    
    func shoot()
    {
        let controller:CCameraShoot = CCameraShoot()
        parentController.push(
            controller:controller,
            vertical:CParent.TransitionVertical.fromTop)
    }
    
    func picker(record:MCameraRecord?)
    {
        let controller:CCameraPicker = CCameraPicker(record:record)
        parentController.push(
            controller:controller,
            vertical:CParent.TransitionVertical.fromTop)
    }
    
    func video()
    {
        let controller:CCameraVideo = CCameraVideo(camera:self)
        present(controller, animated:true, completion:nil)
    }
    
    func loadVideo(url:URL?)
    {
        dismiss(animated:true)
        { [weak self] in
            
            self?.parseVideo(url:url)
        }
    }
    
    func trash(item:MCameraRecord)
    {
        let alert:UIAlertController = UIAlertController(
            title:
            NSLocalizedString("CCamera_alertTitle", comment:""),
            message:nil,
            preferredStyle:UIAlertControllerStyle.actionSheet)
        
        let actionCancel:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CCamera_alertCancel", comment:""),
            style:
            UIAlertActionStyle.cancel)
        
        let actionDelete:UIAlertAction = UIAlertAction(
            title:
            NSLocalizedString("CCamera_alertDelete", comment:""),
            style:
            UIAlertActionStyle.destructive)
        { [weak self] (action:UIAlertAction) in
            
            self?.confirmTrash(item:item)
        }
        
        alert.addAction(actionDelete)
        alert.addAction(actionCancel)
        
        if let popover:UIPopoverPresentationController = alert.popoverPresentationController
        {
            popover.sourceView = viewCamera
            popover.sourceRect = CGRect.zero
            popover.permittedArrowDirections = UIPopoverArrowDirection.up
        }
        
        present(alert, animated:true, completion:nil)
    }
    
    func rotate(item:MCameraRecord)
    {
        let controllerRotate:CCameraRotate = CCameraRotate(record:item)
        parentController.push(
            controller:controllerRotate,
            vertical:CParent.TransitionVertical.fromTop)
    }
    
    func scale(item:MCameraRecord)
    {
        let controllerScale:CCameraScale = CCameraScale(record:item)
        parentController.push(
            controller:controllerScale,
            vertical:CParent.TransitionVertical.fromTop)
    }
    
    func crop(item:MCameraRecord)
    {
        let controllerCrop:CCameraCrop = CCameraCrop(record:item)
        parentController.push(
            controller:controllerCrop,
            vertical:CParent.TransitionVertical.fromTop)
    }
    
    func showMore(item:MCameraRecord)
    {
        let controllerMore:CCameraMore = CCameraMore(controller:self, record:item)
        parentController.animateOver(controller:controllerMore)
    }
    
    func next()
    {
        MSession.sharedInstance.camera?.buildActiveRecords()
        
        let controller:CCameraFilter = CCameraFilter()
        parentController.push(
            controller:controller,
            horizontal:CParent.TransitionHorizontal.fromRight)
    }
    
    func goPlus()
    {
        let controllerGoPlus:CStoreGoPlus = CStoreGoPlus()
        parentController.animateOver(controller:controllerGoPlus)
    }
}
