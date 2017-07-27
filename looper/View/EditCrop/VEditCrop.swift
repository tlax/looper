import UIKit

class VEditCrop:ViewMain
{
    private weak var viewImage:VEditCropImage!
    private weak var layoutOkayLeft:NSLayoutConstraint!
    private weak var layoutResetLeft:NSLayoutConstraint!
    private let kOkayWidth:CGFloat = 195
    private let kOkayBottom:CGFloat = -20
    private let kOkayHeight:CGFloat = 64
    private let kResetHeight:CGFloat = 34
    private let kResetWidth:CGFloat = 120
    private let kImageBottom:CGFloat = -30
    private let kAnimationDuration:TimeInterval = 0.3
    
    required init(controller:UIViewController)
    {
        super.init(controller:controller)
        
        guard
        
            let controller:CEditCrop = controller as? CEditCrop
        
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
        let remainOkay:CGFloat = width - kOkayWidth
        let okayMarginLeft:CGFloat = remainOkay / 2.0
        let remainReset:CGFloat = width - kResetWidth
        let resetMarginLeft:CGFloat = remainReset / 2.0
        layoutOkayLeft.constant = okayMarginLeft
        layoutResetLeft.constant = resetMarginLeft
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionReset(sender button:UIButton)
    {
        viewImage.reset()
        
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.layoutIfNeeded()
        }
    }
    
    //MARK: private
    
    private func factoryViews(controller:CEditCrop)
    {
        let viewImage:VEditCropImage = VEditCropImage(controller:controller)
        self.viewImage = viewImage
        
        let viewOkay:VEditCropOkay = VEditCropOkay(controller:controller)
        
        let buttonReset:UIButton = UIButton()
        buttonReset.translatesAutoresizingMaskIntoConstraints = false
        buttonReset.setTitleColor(
            UIColor.colourGradientDark.withAlphaComponent(0.5),
            for:UIControlState.normal)
        buttonReset.setTitleColor(
            UIColor.colourBackgroundGray,
            for:UIControlState.highlighted)
        buttonReset.setTitle(
            String.localizedView(key:"VEditCrop_buttonReset"),
            for:UIControlState.normal)
        buttonReset.titleLabel!.font = UIFont.medium(size:15)
        buttonReset.addTarget(
            self,
            action:#selector(actionReset(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(viewImage)
        addSubview(buttonReset)
        addSubview(viewOkay)
        
        NSLayoutConstraint.topToTop(
            view:viewImage,
            toView:self)
        NSLayoutConstraint.bottomToTop(
            view:viewImage,
            toView:buttonReset,
            constant:kImageBottom)
        NSLayoutConstraint.equalsHorizontal(
            view:viewImage,
            toView:self)
        
        NSLayoutConstraint.bottomToTop(
            view:buttonReset,
            toView:viewOkay)
        NSLayoutConstraint.height(
            view:buttonReset,
            constant:kResetHeight)
        NSLayoutConstraint.width(
            view:buttonReset,
            constant:kResetWidth)
        layoutResetLeft = NSLayoutConstraint.leftToLeft(
            view:buttonReset,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:viewOkay,
            toView:self,
            constant:kOkayBottom)
        NSLayoutConstraint.height(
            view:viewOkay,
            constant:kOkayHeight)
        NSLayoutConstraint.width(
            view:viewOkay,
            constant:kOkayWidth)
        layoutOkayLeft = NSLayoutConstraint.leftToLeft(
            view:viewOkay,
            toView:self)
    }
    
    //MARK: public
    
    func viewDidAppear()
    {
        viewImage.layout()
    }
}
