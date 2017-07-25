import UIKit

class Controller<T:ViewMain, S:Model>:UIViewController, ModelDelegate
{
    let model:S
    
    init()
    {
        model = S()
        
        super.init(nibName:nil, bundle:nil)
        model.delegate = self
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override var shouldAutorotate:Bool
    {
        get
        {
            return true
        }
    }
    
    override func loadView()
    {
        let view:T = T(controller:self)
        self.view = view
    }
    
    override func viewWillAppear(_ animated:Bool)
    {
        super.viewWillAppear(animated)
        
        parent?.setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        edgesForExtendedLayout = UIRectEdge()
        extendedLayoutIncludesOpaqueBars = false
        automaticallyAdjustsScrollViewInsets = false
    }
    
    override var preferredStatusBarStyle:UIStatusBarStyle
    {
        return UIStatusBarStyle.default
    }
    
    override var prefersStatusBarHidden:Bool
    {
        return false
    }
    
    //MARK: model delegate
    
    func modelRefresh()
    {
    }
}
