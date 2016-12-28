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
    
    //MARK: public
    
    func shoot()
    {
        let controller:CCameraShoot = CCameraShoot(model:model)
        parentController.push(
            controller:controller,
            vertical:CParent.TransitionVertical.fromTop)
    }
}
