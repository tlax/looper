import UIKit

class VCameraPickerBar:UIView
{
    private weak var controller:CCameraPicker!
    private weak var buttonCommit:UIButton!
    private let kContentTop:CGFloat = 20
    private let kButtonWidth:CGFloat = 90
    private let kAlphaEmpty:CGFloat = 0.3
    private let kBorderHeight:CGFloat = 1
    
    init(controller:CCameraPicker)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let title:UILabel = UILabel()
        title.isUserInteractionEnabled = false
        title.translatesAutoresizingMaskIntoConstraints = false
        title.backgroundColor = UIColor.clear
        title.font = UIFont.regular(size:16)
        title.textAlignment = NSTextAlignment.center
        title.textColor = UIColor.black
        title.text = NSLocalizedString("VCameraPickerBar_title", comment:"")
        
        let border:VBorder = VBorder(color:UIColor.black)
        
        let buttonCommit:UIButton = UIButton()
        buttonCommit.translatesAutoresizingMaskIntoConstraints = false
        buttonCommit.setTitle(
            NSLocalizedString("VCameraPickerBar_buttonCommit", comment:""),
            for:UIControlState.normal)
        buttonCommit.setTitleColor(
            UIColor.genericDark,
            for:UIControlState.normal)
        buttonCommit.setTitleColor(
            UIColor.genericDark.withAlphaComponent(0.2),
            for:UIControlState.highlighted)
        buttonCommit.titleLabel!.font = UIFont.bold(size:14)
        self.buttonCommit = buttonCommit
        
        let buttonCancel:UIButton = UIButton()
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        buttonCancel.setTitle(
            NSLocalizedString("VCameraPickerBar_buttonCancel", comment:""),
            for:UIControlState.normal)
        buttonCancel.setTitleColor(
            UIColor.black,
            for:UIControlState.normal)
        buttonCancel.setTitleColor(
            UIColor(white:0, alpha:0.2),
            for:UIControlState.highlighted)
        buttonCancel.titleLabel!.font = UIFont.bold(size:14)
        
        addSubview(border)
        addSubview(title)
        addSubview(buttonCommit)
        addSubview(buttonCancel)
        
        NSLayoutConstraint.topToTop(
            view:title,
            toView:self,
            constant:kContentTop)
        NSLayoutConstraint.bottomToBottom(
            view:title,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:title,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:buttonCancel,
            toView:self,
            constant:kContentTop)
        NSLayoutConstraint.bottomToBottom(
            view:buttonCancel,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:buttonCancel,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonCancel,
            constant:kButtonWidth)
        
        NSLayoutConstraint.topToTop(
            view:buttonCommit,
            toView:self,
            constant:kContentTop)
        NSLayoutConstraint.bottomToBottom(
            view:buttonCommit,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:buttonCommit,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonCommit,
            constant:kButtonWidth)
        
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
        
        config(amount:0)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionCancel()
    {
        controller.cancel()
    }
    
    func actionCommit(sender button:UIButton)
    {
        controller.commit()
    }
    
    //MARK: public
    
    func config(amount:Int)
    {
        if amount > 0
        {
            buttonCommit.isUserInteractionEnabled = true
            buttonCommit.alpha = 1
        }
        else
        {
            buttonCommit.isUserInteractionEnabled = false
            buttonCommit.alpha = kAlphaEmpty
        }
    }
}
