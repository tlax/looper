import UIKit

class VNew:ViewMain
{
    private weak var viewSource:VNewSource!
    private weak var layoutCancelLeft:NSLayoutConstraint!
    private weak var layoutSourceBottom:NSLayoutConstraint!
    private let kCancelSize:CGFloat = 120
    private let kAnimationDuration:TimeInterval = 0.4
    private let kBlurAlpha:CGFloat = 0.95
    
    required init(controller:UIViewController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        
        guard
        
            let controller:CNew = controller as? CNew
        
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
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.width
        let remainCancel:CGFloat = width - kCancelSize
        let marginCancel:CGFloat = remainCancel / 2.0
        layoutCancelLeft.constant = marginCancel
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionCancel(sender button:UIButton)
    {
        guard
        
            let controller:CNew = self.controller as? CNew
        
        else
        {
            return
        }
        
        controller.cancel()
    }
    
    //MARK: private
    
    private func factoryViews(controller:CNew)
    {
        let sourceBottom:CGFloat = UIScreen.main.bounds.height
        let sourceItems:CGFloat = CGFloat(controller.model.items.count)
        
        let baseBlur:UIView = UIView()
        baseBlur.isUserInteractionEnabled = false
        baseBlur.translatesAutoresizingMaskIntoConstraints = false
        baseBlur.clipsToBounds = true
        baseBlur.alpha = kBlurAlpha
        
        let blur:VBlur = VBlur.light()
        
        let buttonBackground:UIButton = UIButton()
        buttonBackground.translatesAutoresizingMaskIntoConstraints = false
        buttonBackground.clipsToBounds = true
        buttonBackground.addTarget(
            self,
            action:#selector(actionCancel(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonCancel:UIButton = UIButton()
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        buttonCancel.setImage(
            #imageLiteral(resourceName: "assetGenericNewClose"),
            for:UIControlState.normal)
        buttonCancel.imageView!.clipsToBounds = true
        buttonCancel.imageView!.contentMode = UIViewContentMode.center
        buttonCancel.addTarget(
            self,
            action:#selector(actionCancel(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let viewSource:VNewSource = VNewSource(controller:controller)
        viewSource.alpha = 0
        self.viewSource = viewSource
        
        let sourceHeight:CGFloat = viewSource.kCellHeight * sourceItems
        
        baseBlur.addSubview(blur)
        addSubview(baseBlur)
        addSubview(buttonBackground)
        addSubview(viewSource)
        addSubview(buttonCancel)
        
        NSLayoutConstraint.equals(
            view:baseBlur,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:baseBlur)
        
        NSLayoutConstraint.equals(
            view:buttonBackground,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:buttonCancel,
            toView:self)
        NSLayoutConstraint.size(
            view:buttonCancel,
            constant:kCancelSize)
        layoutCancelLeft = NSLayoutConstraint.leftToLeft(
            view:buttonCancel,
            toView:self)
        
        layoutSourceBottom = NSLayoutConstraint.bottomToTop(
            view:viewSource,
            toView:buttonCancel,
            constant:sourceBottom)
        NSLayoutConstraint.height(
            view:viewSource,
            constant:sourceHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewSource,
            toView:self)
    }
    
    //MARK: public
    
    func viewWillAppear()
    {
        layoutSourceBottom.constant = 0
        
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.layoutIfNeeded()
            self?.viewSource.alpha = 1
        }
    }
    
    func viewWillDisappear()
    {
        let sourceBottom:CGFloat = UIScreen.main.bounds.height
        layoutSourceBottom.constant = sourceBottom
        
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.layoutIfNeeded()
        }
    }
}
