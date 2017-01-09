import UIKit

class CCamera:CController
{
    weak var viewCamera:VCamera!
    private let kAfterShoot:TimeInterval = 0.4
    
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
        
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kAfterShoot)
        { [weak self] in
            
            guard
                
                let model:MCamera = MSession.sharedInstance.camera
            
            else
            {
                return
            }
            
            if model.records.isEmpty
            {
                self?.shoot()
            }
        }
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        viewCamera.refresh()
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
    
    //MARK: public
    
    func shoot()
    {
        let controller:CCameraShoot = CCameraShoot()
        parentController.push(
            controller:controller,
            vertical:CParent.TransitionVertical.fromTop)
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
        present(alert, animated:true, completion:nil)
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
