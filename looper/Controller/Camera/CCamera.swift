import UIKit

class CCamera:CController
{
    weak var viewCamera:VCamera!
    private var refreshCamera:Bool
    private let kAfterShoot:TimeInterval = 0.6
    
    override init()
    {
        refreshCamera = false
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
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
        
        guard
            
            let model:MCamera = MSession.sharedInstance.camera
            
        else
        {
            return
        }
        
        if model.records.isEmpty
        {
            DispatchQueue.main.asyncAfter(
                deadline:DispatchTime.now() + kAfterShoot)
            { [weak self] in
                
                self?.refreshCamera = true
                self?.shoot()
            }
        }
        else
        {
            refreshCamera = true
            viewCamera.refresh()
        }
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
    
    private func confirmTrash(item:MCameraRecordEditable)
    {
        MSession.sharedInstance.camera?.trashRecord(record:item)
        viewCamera.refresh()
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
    
    func picker(editable:MCameraRecordEditable?)
    {
        let controller:CCameraPicker = CCameraPicker(camera:self, editable:editable)
        present(controller, animated:true, completion:nil)
    }
    
    func trash(item:MCameraRecordEditable)
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
    
    func rotate(item:MCameraRecordEditable)
    {
        let controllerRotate:CCameraRotate = CCameraRotate(record:item)
        parentController.push(
            controller:controllerRotate,
            vertical:CParent.TransitionVertical.fromTop)
    }
    
    func scale(item:MCameraRecordEditable)
    {
        let controllerScale:CCameraScale = CCameraScale(record:item)
        parentController.push(
            controller:controllerScale,
            vertical:CParent.TransitionVertical.fromTop)
    }
    
    func crop(item:MCameraRecordEditable)
    {
        let controllerCrop:CCameraCrop = CCameraCrop(record:item)
        parentController.push(
            controller:controllerCrop,
            vertical:CParent.TransitionVertical.fromTop)
    }
    
    func showMore(item:MCameraRecordEditable)
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
