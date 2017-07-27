import UIKit

class ControllerParent:UIViewController
{
    private var orientation:UIInterfaceOrientationMask
    private let kOrientationKey:String = "orientation"
    
    init()
    {
        orientation = UIInterfaceOrientationMask.portrait
        super.init(nibName:nil, bundle:nil)
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

        let controller:CHome = CHome()
        mainController(controller:controller)
        
        MSession.sharedInstance.loadSession()
    }
    
    override func loadView()
    {
        let viewParent:ViewParent = ViewParent(controller:self)
        view = viewParent
    }
    
    override var preferredStatusBarStyle:UIStatusBarStyle
    {
        guard
        
            let controller:UIViewController = childViewControllers.last
        
        else
        {
            return UIStatusBarStyle.default
        }
        
        return controller.preferredStatusBarStyle
    }
    
    override var prefersStatusBarHidden:Bool
    {
        guard
            
            let controller:UIViewController = childViewControllers.last
            
        else
        {
            return false
        }
        
        return controller.prefersStatusBarHidden
    }
    
    override var supportedInterfaceOrientations:UIInterfaceOrientationMask
    {
        get
        {
            return orientation
        }
    }
    
    override var shouldAutorotate:Bool
    {
        get
        {
            return true
        }
    }
    
    //MARK: private
    
    private func updateOrientation(orientation:UIInterfaceOrientation)
    {
        UIDevice.current.setValue(
            orientation.rawValue,
            forKey:kOrientationKey)
        UIViewController.attemptRotationToDeviceOrientation()
    }
    
    //MARK: public
    
    func landscapeOrientation()
    {
        orientation = UIInterfaceOrientationMask.landscape
        updateOrientation(
            orientation:UIInterfaceOrientation.landscapeLeft)
    }
    
    func portraitOrientation()
    {
        orientation = UIInterfaceOrientationMask.portrait
        updateOrientation(
            orientation:UIInterfaceOrientation.portrait)
    }
}
