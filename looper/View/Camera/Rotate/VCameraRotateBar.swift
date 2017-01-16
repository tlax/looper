import UIKit

class VCameraRotateBar:UIView
{
    private weak var controller:CCameraRotate!
    private weak var buttonSave:UIButton!
    private weak var buttonReset:UIButton!
    private let kBorderHeight:CGFloat = 1
    private let kButtonTop:CGFloat = 20
    private let kButtonWidth:CGFloat = 120
    
    convenience init(controller:CCameraRotate)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let border:VBorder = VBorder(color:UIColor(white:0, alpha:0.1))
        
        let buttonSave:UIButton = UIButton()
        buttonSave.translatesAutoresizingMaskIntoConstraints = false
        buttonSave.setTitleColor(
            UIColor.genericLight,
            for:UIControlState.normal)
        buttonSave.setTitleColor(
            UIColor.genericLight.withAlphaComponent(0.2),
            for:UIControlState.highlighted)
        buttonSave.setTitle(
            NSLocalizedString("VCameraRotateBar_buttonSave", comment:""),
            for:UIControlState.normal)
        buttonSave.titleLabel!.font = UIFont.bold(size:17)
        buttonSave.addTarget(
            self,
            action:#selector(actionSave(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonReset:UIButton = UIButton()
        buttonReset.translatesAutoresizingMaskIntoConstraints = false
        buttonReset.setTitleColor(
            UIColor(red:1, green:0.2, blue:0, alpha:1),
            for:UIControlState.normal)
        buttonReset.setTitleColor(
            UIColor(red:1, green:0.2, blue:0, alpha:0.2),
            for:UIControlState.highlighted)
        buttonReset.setTitle(
            NSLocalizedString("VCameraRotateBar_buttonReset", comment:""),
            for:UIControlState.normal)
        buttonReset.titleLabel!.font = UIFont.bold(size:17)
        buttonReset.addTarget(
            self,
            action:#selector(actionReset(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(border)
        addSubview(buttonSave)
        addSubview(buttonReset)
        
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        
        NSLayoutConstraint.topToTop(
            view:buttonSave,
            toView:self,
            constant:kButtonTop)
        NSLayoutConstraint.bottomToBottom(
            view:buttonSave,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:buttonSave,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonSave,
            constant:kButtonWidth)
        
        NSLayoutConstraint.topToTop(
            view:buttonReset,
            toView:self,
            constant:kButtonTop)
        NSLayoutConstraint.bottomToBottom(
            view:buttonReset,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:buttonReset,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonReset,
            constant:kButtonWidth)
    }

    //MARK: actions
    
    func actionSave(sender button:UIButton)
    {
        button.isUserInteractionEnabled = false
        controller.save()
    }
    
    func actionReset(sender button:UIButton)
    {
        controller.viewRotate.reset()
    }
}
