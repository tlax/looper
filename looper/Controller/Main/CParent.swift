import UIKit

class CParent:UIViewController
{
    weak var viewParent:VParent!
    private var statusBarStyle:UIStatusBarStyle
    private var barHidden:Bool
    
    init()
    {
        statusBarStyle = UIStatusBarStyle.default
        barHidden = false
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let loops:CLoops = CLoops()
        mainController(controller:loops)
        
        MSession.sharedInstance.loadSettings()
    }
    
    override func loadView()
    {
        let viewParent:VParent = VParent(controller:self)
        self.viewParent = viewParent
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
    
    //MARK: private
    
    private func slide(controller:CController, left:CGFloat)
    {
        guard
            
            let currentController:CController = childViewControllers.last as? CController,
            let newView:VView = controller.view as? VView,
            let currentView:VView = currentController.view as? VView
            
        else
        {
            return
        }
        
        addChildViewController(controller)
        controller.beginAppearanceTransition(true, animated:true)
        currentController.beginAppearanceTransition(false, animated:true)
        
        viewParent.slide(
            currentView:currentView,
            newView:newView,
            left:left)
        {
            controller.endAppearanceTransition()
            currentController.endAppearanceTransition()
            currentController.removeFromParentViewController()
        }
    }
    
    //MARK: public
    
    func changeBar(barHidden:Bool)
    {
        self.barHidden = barHidden
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func mainController(controller:CController)
    {
        addChildViewController(controller)
        controller.beginAppearanceTransition(true, animated:false)
        
        guard
            
            let newView:VView = controller.view as? VView
        
        else
        {
            return
        }
            
        viewParent.mainView(view:newView)
        controller.endAppearanceTransition()
    }
    
    func moveToCamera()
    {
        let left:CGFloat = -viewParent.bounds.maxX
        let controller:CCamera = CCamera()
        
        slide(controller:controller, left:left)
    }
    
    func moveToStore()
    {
        let left:CGFloat = viewParent.bounds.maxX
        let controller:CCamera = CCamera()
        
        slide(controller:controller, left:left)
    }
    
    func moveToLoops()
    {
        let left:CGFloat
        
        if let _:CCamera = childViewControllers.last as? CCamera
        {
            left = viewParent.bounds.maxX
        }
        else
        {
            left = -viewParent.bounds.maxX
        }
        
        let controller:CLoops = CLoops()
        
        slide(controller:controller, left:left)
    }
    
    func push(controller:CController, deltaX:CGFloat, deltaY:CGFloat)
    {
        let width:CGFloat = viewParent.bounds.maxX
        let height:CGFloat = viewParent.bounds.maxY
        let left:CGFloat = width * deltaX
        let top:CGFloat = height * deltaY
        
        guard
            
            let currentController:CController = childViewControllers.last as? CController,
            let newView:VView = controller.view as? VView
            
        else
        {
            return
        }
        
        addChildViewController(controller)
        controller.beginAppearanceTransition(true, animated:true)
        currentController.beginAppearanceTransition(false, animated:true)
        
        viewParent.push(
            newView:newView,
            left:left,
            top:top)
        {
            controller.endAppearanceTransition()
            currentController.endAppearanceTransition()
        }
    }
}
