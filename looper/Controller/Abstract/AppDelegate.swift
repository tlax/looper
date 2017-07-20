import UIKit

@UIApplicationMain
class AppDelegate:UIResponder, UIApplicationDelegate
{
    var window:UIWindow?
    
    func application(
        _ application:UIApplication,
        didFinishLaunchingWithOptions
        launchOptions:[UIApplicationLaunchOptionsKey:Any]?) -> Bool
    {
        let window:UIWindow = UIWindow(frame:UIScreen.main.bounds)
        window.backgroundColor = UIColor.white
        window.makeKeyAndVisible()
        
        let parent:ControllerParent = ControllerParent()
        window.rootViewController = parent
        self.window = window
        
        return true
    }
    
    func applicationDidBecomeActive(_ application:UIApplication)
    {
        MSession.sharedInstance.settings?.addTtl()
    }
}
