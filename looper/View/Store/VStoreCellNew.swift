import UIKit

class VStoreCellNew:VStoreCell
{
    private weak var labelPrice:UILabel!
    private let kButtonPurchaseWidth:CGFloat = 100
    private let kLabelPriceWidth:CGFloat = 200
    private let kLabelButtonSeparation:CGFloat = -10
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let buttonPurchase:UIButton = UIButton()
        buttonPurchase.translatesAutoresizingMaskIntoConstraints = false
        buttonPurchase.backgroundColor = UIColor.genericBlue
        buttonPurchase.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        buttonPurchase.setTitleColor(
            UIColor.black,
            for:UIControlState.highlighted)
        buttonPurchase.setTitle(
            NSLocalizedString("VStoreCellNew_buttonPurchase", comment:""),
            for:UIControlState.normal)
        buttonPurchase.titleLabel!.font = UIFont.medium(size:15)
        buttonPurchase.addTarget(
            self,
            action:#selector(actionPurchase(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let labelPrice:UILabel = UILabel()
        labelPrice.isUserInteractionEnabled = false
        labelPrice.translatesAutoresizingMaskIntoConstraints = false
        labelPrice.backgroundColor = UIColor.clear
        labelPrice.font = UIFont.medium(size:16)
        labelPrice.textColor = UIColor.black
        labelPrice.textAlignment = NSTextAlignment.right
        self.labelPrice = labelPrice
        
        addSubview(buttonPurchase)
        addSubview(labelPrice)
        
        let layoutLabelTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:labelPrice,
            toView:self)
        let layoutLabelBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:labelPrice,
            toView:self)
        let layoutLabelRight:NSLayoutConstraint = NSLayoutConstraint.rightToLeft(
            view:labelPrice,
            toView:self,
            constant:kLabelButtonSeparation)
        let layoutLabelWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:labelPrice,
            constant:kLabelPriceWidth)
        
        let layoutButtonTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:buttonPurchase,
            toView:self)
        let layoutButtonBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:buttonPurchase,
            toView:self)
        let layoutButtonRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:buttonPurchase,
            toView:self)
        let layoutButtonWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:buttonPurchase,
            constant:kButtonPurchaseWidth)
        
        addConstraints([
            layoutLabelTop,
            layoutLabelBottom,
            layoutLabelRight,
            layoutLabelWidth,
            layoutButtonTop,
            layoutButtonBottom,
            layoutButtonRight,
            layoutButtonWidth])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func config(controller:CStore, model:MStoreItem)
    {
        super.config(controller:controller, model:model)
        labelPrice.text = model.price
    }
    
    //MARK: actions
    
    func actionPurchase(sender button:UIButton)
    {
        controller?.purchase(skProduct:model?.skProduct)
    }
}
