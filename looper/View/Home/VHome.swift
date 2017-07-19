import UIKit

class VHome:View
{
    private(set) weak var viewOptions:VHomeOptions!
    private weak var viewHeader:VHomeHeader!
    private weak var viewFooter:VHomeFooter!
    private weak var spinner:VSpinner?
    private let kHeaderHeight:CGFloat = 170
    private let kFooterHeight:CGFloat = 140
    
    required init(controller:UIViewController)
    {
        super.init(controller:controller)
        
        guard
        
            let controller:CHome = self.controller as? CHome
        
        else
        {
            return
        }
        
        let viewHeader:VHomeHeader = VHomeHeader(controller:controller)
        self.viewHeader = viewHeader
        
        let viewOptions:VHomeOptions = VHomeOptions(controller:controller)
        self.viewOptions = viewOptions
        
        let viewFooter:VHomeFooter = VHomeFooter(controller:controller)
        self.viewFooter = viewFooter
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        addSubview(spinner)
        addSubview(viewHeader)
        addSubview(viewOptions)
        addSubview(viewFooter)
        
        NSLayoutConstraint.equals(
            view:spinner,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:viewHeader,
            toView:self)
        NSLayoutConstraint.height(
            view:viewHeader,
            constant:kHeaderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewHeader,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:viewOptions,
            toView:viewHeader)
        NSLayoutConstraint.bottomToTop(
            view:viewOptions,
            toView:viewFooter)
        NSLayoutConstraint.equalsHorizontal(
            view:viewOptions,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:viewFooter,
            toView:self)
        NSLayoutConstraint.height(
            view:viewFooter,
            constant:kFooterHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewFooter,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    deinit
    {
        spinner?.stopAnimating()
    }
    
    //MARK: public
    
    func sessionLoaded()
    {
        spinner?.stopAnimating()
        spinner?.removeFromSuperview()
        
        viewOptions.refresh()
        viewHeader.isHidden = false
        viewFooter.isHidden = false
    }
}
