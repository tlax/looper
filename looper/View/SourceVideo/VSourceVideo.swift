import UIKit

class VSourceVideo:ViewMain
{
    private weak var spinner:VSpinner?
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
        
        addSubview(spinner)
        
        NSLayoutConstraint.equals(
            view:spinner,
            toView:self)
    }
}
