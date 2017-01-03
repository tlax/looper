import UIKit

class VCameraCompressBar:UIView
{
    private weak var controller:CCameraCompress!
    private weak var backButton:UIButton!
    private weak var nextButton:UIButton!
    private weak var layoutIconLeft:NSLayoutConstraint!
    private let kContentTop:CGFloat = 20
    private let kButtonsWidth:CGFloat = 55
    private let kIconWidth:CGFloat = 60
    private let kAlphaActive:CGFloat = 1
    private let kAlphaNotActive:CGFloat = 0.3
    
    convenience init(controller:CCameraCompress)
    {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        clipsToBounds = true
        self.controller = controller
        
        let blurEffect:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.light)
        let visualEffect:UIVisualEffectView = UIVisualEffectView(
            effect:blurEffect)
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        visualEffect.clipsToBounds = true
        visualEffect.isUserInteractionEnabled = false
        
        let backButton:UIButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        backButton.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        backButton.imageView!.contentMode = UIViewContentMode.center
        backButton.imageView!.clipsToBounds = true
        backButton.imageView!.tintColor = UIColor(white:0, alpha:0.2)
        backButton.addTarget(
            self,
            action:#selector(actionBack(sender:)),
            for:UIControlEvents.touchUpInside)
        self.backButton = backButton
        
        let nextButton:UIButton = UIButton()
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setImage(
            #imageLiteral(resourceName: "assetGenericNext").withRenderingMode(
                UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        nextButton.setImage(
            #imageLiteral(resourceName: "assetGenericNext").withRenderingMode(
                UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        nextButton.imageView!.contentMode = UIViewContentMode.center
        nextButton.imageView!.tintColor = UIColor(white:0, alpha:0.2)
        nextButton.imageView!.clipsToBounds = true
        nextButton.addTarget(
            self,
            action:#selector(actionNext(sender:)),
            for:UIControlEvents.touchUpInside)
        self.nextButton = nextButton
        
        let icon:UIImageView = UIImageView()
        icon.isUserInteractionEnabled = false
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.clipsToBounds = true
        icon.contentMode = UIViewContentMode.center
        icon.image = #imageLiteral(resourceName: "assetCameraCompress")
        
        addSubview(visualEffect)
        addSubview(icon)
        addSubview(backButton)
        addSubview(nextButton)
        
        let layoutEffectTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:visualEffect,
            toView:self)
        let layoutEffectBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:visualEffect,
            toView:self)
        let layoutEffectLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:visualEffect,
            toView:self)
        let layoutEffectRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:visualEffect,
            toView:self)
        
        let layoutBackTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:backButton,
            toView:self,
            constant:kContentTop)
        let layoutBackBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:backButton,
            toView:self)
        let layoutBackLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:backButton,
            toView:self)
        let layoutBackWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:backButton,
            constant:kButtonsWidth)
        
        let layoutIconTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:icon,
            toView:self,
            constant:kContentTop)
        let layoutIconBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:icon,
            toView:self)
        layoutIconLeft = NSLayoutConstraint.leftToLeft(
            view:icon,
            toView:self)
        let layoutIconWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:icon,
            constant:kIconWidth)
        
        let layoutNextTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:nextButton,
            toView:self,
            constant:kContentTop)
        let layoutNextBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:nextButton,
            toView:self)
        let layoutNextRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:nextButton,
            toView:self)
        let layoutNextWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:nextButton,
            constant:kButtonsWidth)
        
        addConstraints([
            layoutEffectTop,
            layoutEffectBottom,
            layoutEffectLeft,
            layoutEffectRight,
            layoutBackTop,
            layoutBackBottom,
            layoutBackLeft,
            layoutBackWidth,
            layoutIconTop,
            layoutIconBottom,
            layoutIconLeft,
            layoutIconWidth,
            layoutNextTop,
            layoutNextBottom,
            layoutNextRight,
            layoutNextWidth])
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remainIcon:CGFloat = width - kIconWidth
        let margin:CGFloat = remainIcon / 2.0
        layoutIconLeft.constant = margin
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionBack(sender button:UIButton)
    {
        controller.back()
    }
    
    func actionNext(sender button:UIButton)
    {
        controller.next()
    }
    
    //MARK: public
    
    func startLoading()
    {
        backButton.isUserInteractionEnabled = false
        nextButton.isUserInteractionEnabled = false
        backButton.alpha = kAlphaNotActive
        nextButton.alpha = kAlphaNotActive
    }
    
    func stopLoading()
    {
        backButton.isUserInteractionEnabled = true
        nextButton.isUserInteractionEnabled = true
        backButton.alpha = kAlphaActive
        nextButton.alpha = kAlphaActive
    }
}
