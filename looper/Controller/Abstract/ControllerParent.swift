import UIKit

class ControllerParent:UIViewController
{
    private var barHidden:Bool = true
    private var statusBarStyle:UIStatusBarStyle = UIStatusBarStyle.lightContent
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
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(notifiedEnterForeground(sender:)),
            name:Notification.enterForeground,
            object:nil)
        
        MSession.sharedInstance.loadSession()
    }
    
    override func loadView()
    {
        let viewParent:ViewParent = ViewParent(controller:self)
        view = viewParent
    }
    
    override var preferredStatusBarStyle:UIStatusBarStyle
    {
        return statusBarStyle
    }
    
    override var prefersStatusBarHidden:Bool
    {
        return barHidden
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
    
    func hideBar(barHidden:Bool)
    {
        self.barHidden = barHidden
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func statusBarAppareance(statusBarStyle:UIStatusBarStyle)
    {
        self.statusBarStyle = statusBarStyle
        setNeedsStatusBarAppearanceUpdate()
    }
    
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
