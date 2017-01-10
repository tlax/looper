import UIKit

class VStoreGoPlus:VView
{
    private weak var controller:CStoreGoPlus!
    private weak var layoutBaseViewLeft:NSLayoutConstraint!
    private weak var layoutBaseViewTop:NSLayoutConstraint!
    private let kBaseWidth:CGFloat = 299
    private let kBaseHeight:CGFloat = 180
    private let kButtonHeight:CGFloat = 54
    private let kCornerRadius:CGFloat = 20
    private let kLabelTitleHeight:CGFloat = 25
    private let kLabelDescrHeight:CGFloat = 20
    private let kImageTop:CGFloat = -55
    private let kImageHeight:CGFloat = 110
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CStoreGoPlus
        
        let blurEffect:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.dark)
        let visualEffect:UIVisualEffectView = UIVisualEffectView(effect:blurEffect)
        visualEffect.isUserInteractionEnabled = false
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        visualEffect.clipsToBounds = true
        
        let baseButton:UIButton = UIButton()
        baseButton.clipsToBounds = true
        baseButton.backgroundColor = UIColor.clear
        baseButton.translatesAutoresizingMaskIntoConstraints = false
        baseButton.addTarget(
            self,
            action:#selector(self.actionClose(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let baseView:UIView = UIView()
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.clipsToBounds = true
        baseView.backgroundColor = UIColor.white
        baseView.layer.cornerRadius = kCornerRadius
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.font = UIFont.bold(size:20)
        labelTitle.textColor = UIColor.black
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.text = NSLocalizedString("VStoreGoPlus_title", comment:"")
        
        let labelDescr:UILabel = UILabel()
        labelDescr.isUserInteractionEnabled = false
        labelDescr.font = UIFont.regular(size:15)
        labelDescr.textColor = UIColor.black
        labelDescr.textAlignment = NSTextAlignment.center
        labelDescr.backgroundColor = UIColor.clear
        labelDescr.numberOfLines = 0
        labelDescr.translatesAutoresizingMaskIntoConstraints = false
        labelDescr.text = NSLocalizedString("VStoreGoPlus_descr", comment:"")
        
        let buttons:VStoreGoPlusButtons = VStoreGoPlusButtons(
            controller:self.controller)
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.image = #imageLiteral(resourceName: "assetGenericGoPlus")
        
        baseView.addSubview(labelTitle)
        baseView.addSubview(labelDescr)
        baseView.addSubview(buttons)
        addSubview(visualEffect)
        addSubview(baseButton)
        addSubview(baseView)
        addSubview(imageView)
        
        let constraintsEffect:[NSLayoutConstraint] = NSLayoutConstraint.equals(
            view:visualEffect,
            toView:self)
        let constraintsBaseButton:[NSLayoutConstraint] = NSLayoutConstraint.equals(
            view:baseButton,
            toView:self)
        
        layoutBaseViewTop = NSLayoutConstraint.topToTop(
            view:baseView,
            toView:self)
        layoutBaseViewLeft = NSLayoutConstraint.leftToLeft(
            view:baseView,
            toView:self)
        let layoutBaseViewWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:baseView,
            constant:kBaseWidth)
        let layoutBaseViewHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:baseView,
            constant:kBaseHeight)
        
        let layoutTitleTop:NSLayoutConstraint = NSLayoutConstraint.topToBottom(
            view:labelTitle,
            toView:imageView)
        let layoutTitleHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:labelTitle,
            constant:kLabelTitleHeight)
        let layoutTitleLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:labelTitle,
            toView:baseView)
        let layoutTitleRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:labelTitle,
            toView:baseView)
        
        let layoutDescrTop:NSLayoutConstraint = NSLayoutConstraint.topToBottom(
            view:labelDescr,
            toView:labelTitle)
        let layoutDescrHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:labelDescr,
            constant:kLabelDescrHeight)
        let layoutDescrLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:labelDescr,
            toView:baseView)
        let layoutDescrRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:labelDescr,
            toView:baseView)
        
        let layoutImageTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:imageView,
            toView:baseView,
            constant:kImageTop)
        let layoutImageHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:imageView,
            constant:kImageHeight)
        let layoutImageLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:imageView,
            toView:baseView)
        let layoutImageRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:imageView,
            toView:baseView)
        
        let layoutButtonsBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:buttons,
            toView:baseView)
        let layoutButtonsHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:buttons,
            constant:kButtonHeight)
        let layoutButtonsLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:buttons,
            toView:baseView)
        let layoutButtonsRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:buttons,
            toView:baseView)
        
        addConstraints(constraintsEffect)
        addConstraints(constraintsBaseButton)
        
        addConstraints([
            layoutBaseViewTop,
            layoutBaseViewLeft,
            layoutBaseViewWidth,
            layoutBaseViewHeight,
            layoutTitleTop,
            layoutTitleHeight,
            layoutTitleLeft,
            layoutTitleRight,
            layoutDescrTop,
            layoutDescrHeight,
            layoutDescrLeft,
            layoutDescrRight,
            layoutImageTop,
            layoutImageHeight,
            layoutImageLeft,
            layoutImageRight,
            layoutButtonsHeight,
            layoutButtonsBottom,
            layoutButtonsLeft,
            layoutButtonsRight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let height:CGFloat = bounds.maxY
        let remainLeft:CGFloat = width - kBaseWidth
        let remainTop:CGFloat = height - kBaseHeight
        let marginLeft:CGFloat = remainLeft / 2.0
        let marginTop:CGFloat = remainTop / 2.0
        layoutBaseViewLeft.constant = marginLeft
        layoutBaseViewTop.constant = marginTop
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionClose(sender button:UIButton)
    {
        controller.close()
    }
}
