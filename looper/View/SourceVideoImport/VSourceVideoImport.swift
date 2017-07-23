import UIKit

class VSourceVideoImport:ViewMain
{
    private(set) weak var viewProgress:VSourceVideoImportProgress!
    private weak var spinner:VSpinner!
    private weak var layoutCancelLeft:NSLayoutConstraint!
    private let kProgressMarginHorizontal:CGFloat = 20
    private let kProgressHeight:CGFloat = 10
    private let kProgressBottom:CGFloat = -30
    private let kGradientHeight:CGFloat = 30
    private let kCancelWidth:CGFloat = 140
    private let kCancelHeight:CGFloat = 40
    private let kCancelBottom:CGFloat = -20
    
    required init(controller:UIViewController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        
        guard
        
            let controller:CSourceVideoImport = controller as? CSourceVideoImport
        
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
        spinner.stopAnimating()
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.width
        let remainCancel:CGFloat = width - kCancelWidth
        let marginCancel:CGFloat = remainCancel / 2.0
        layoutCancelLeft.constant = marginCancel
        
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func factoryViews(controller:CSourceVideoImport)
    {
        let blur:VBlur = VBlur.extraLight()
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        let viewGradient:VGradient = VGradient.vertical(
            colourTop:UIColor(white:0, alpha:0.25),
            colourBottom:UIColor.clear)
        
        let buttonCancel:UIButton = UIButton()
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        buttonCancel.setTitle(
            String.localizedView(key:"VSourceVideoImport_buttonCancel"),
            for:UIControlState.normal)
        buttonCancel.setTitleColor(
            UIColor.black,
            for:UIControlState.normal)
        buttonCancel.setTitleColor(
            UIColor(white:0, alpha:0.2),
            for:UIControlState.highlighted)
        buttonCancel.titleLabel!.font = UIFont.bold(size:16)
        buttonCancel.addTarget(
            self,
            action:#selector(actionCancel(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let viewProgress:VSourceVideoImportProgress = VSourceVideoImportProgress(
            controller:controller)
        self.viewProgress = viewProgress
        
        addSubview(blur)
        addSubview(viewGradient)
        addSubview(spinner)
        addSubview(viewProgress)
        addSubview(buttonCancel)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:spinner,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:viewGradient,
            toView:self)
        NSLayoutConstraint.height(
            view:viewGradient,
            constant:kGradientHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewGradient,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:buttonCancel,
            toView:self,
            constant:kCancelBottom)
        NSLayoutConstraint.height(
            view:buttonCancel,
            constant:kCancelHeight)
        layoutCancelLeft = NSLayoutConstraint.leftToLeft(
            view:buttonCancel,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonCancel,
            constant:kCancelWidth)
        
        NSLayoutConstraint.bottomToTop(
            view:viewProgress,
            toView:buttonCancel,
            constant:kProgressBottom)
        NSLayoutConstraint.height(
            view:viewProgress,
            constant:kProgressHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewProgress,
            toView:self,
            margin:kProgressMarginHorizontal)
    }
    
    //MARK: actions
    
    func actionCancel(sender button:UIButton)
    {
        guard
        
            let controller:CSourceVideoImport = self.controller as? CSourceVideoImport
        
        else
        {
            return
        }
        
        controller.cancel()
    }
}
