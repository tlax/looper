import UIKit

class CCamera:CController
{
    weak var viewCamera:VCamera!
    let model:MCamera

    override init()
    {
        model = MCamera()
        
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
        model.trashRecord(record:item)
        viewCamera.refresh()
    }
    
    //MARK: public
    
    func shoot()
    {
        let controller:CCameraShoot = CCameraShoot(model:model)
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
        let controller:CCameraFilter = CCameraFilter(model:model)
        parentController.push(
            controller:controller,
            horizontal:CParent.TransitionHorizontal.fromRight)
    }
}
