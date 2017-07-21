import UIKit

class VSourceVideo:ViewMain
{
    private weak var spinner:VSpinner?
    private let kBarMinHeight:CGFloat = 64
    private let kPanBack:Bool = true
    
    required init(controller:UIViewController)
    {
        super.init(controller:controller)
        
        guard
        
            let controller:CSourceVideo = controller as? CSourceVideo
        
        else
        {
            return
        }
        
        factoryViews(controller:controller)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    deinit
    {
        spinner?.stopAnimating()
    }
    
    override var panBack:Bool
    {
        get
        {
            return kPanBack
        }
    }
    
    //MARK: private
    
    private func factoryViews(controller:CSourceVideo)
    {
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        let viewBar:VSourceVideoBar = VSourceVideoBar(controller:controller)
        
        addSubview(spinner)
        addSubview(viewBar)
        
        NSLayoutConstraint.equals(
            view:spinner,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBar,
            constant:kBarMinHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
    }
}
