import UIKit

class VHomePlayerBoard:UIView
{
    weak var buttonMain:VHomePlayerBoardMain!
    private weak var buttonShare:UIButton!
    private weak var controller:CHome!
    private weak var layoutMainLeft:NSLayoutConstraint!
    private let kMainWidth:CGFloat = 70
    private let kShareWidth:CGFloat = 60
    private let kButtonsHeight:CGFloat = 60
    private let kAlphaActive:CGFloat = 1
    private let kAlphaNotActive:CGFloat = 0.3
    
    convenience init(controller:CHome)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let buttonMain:VHomePlayerBoardMain = VHomePlayerBoardMain(
            controller:controller)
        self.buttonMain = buttonMain
        
        let buttonShare:UIButton = UIButton()
        buttonShare.translatesAutoresizingMaskIntoConstraints = false
        buttonShare.setImage(
            #imageLiteral(resourceName: "assetHomePlayerShare"),
            for:UIControlState.normal)
        buttonShare.setImage(
            #imageLiteral(resourceName: "assetHomePlayerShareSelected"),
            for:UIControlState.highlighted)
        buttonShare.imageView!.clipsToBounds = true
        buttonShare.imageView!.contentMode = UIViewContentMode.center
        buttonShare.addTarget(
            self,
            action:#selector(actionShare(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonShare = buttonShare
        
        addSubview(buttonMain)
        addSubview(buttonShare)
        
        let layoutMainHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:buttonMain,
            constant:kButtonsHeight)
        let layoutMainBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:buttonMain,
            toView:self)
        layoutMainLeft = NSLayoutConstraint.leftToLeft(
            view:buttonMain,
            toView:self)
        let layoutMainWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:buttonMain,
            constant:kMainWidth)
        
        let layoutShareHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:buttonShare,
            constant:kButtonsHeight)
        let layoutShareBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:buttonShare,
            toView:self)
        let layoutShareRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:buttonShare,
            toView:self)
        let layoutShareWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:buttonShare,
            constant:kShareWidth)
        
        addConstraints([
            layoutMainHeight,
            layoutMainBottom,
            layoutMainLeft,
            layoutMainWidth,
            layoutShareHeight,
            layoutShareBottom,
            layoutShareRight,
            layoutShareWidth])
    }
    
    override func layoutSubviews()
    {
        let totalWidth:CGFloat = bounds.maxX
        let mainRemain:CGFloat = totalWidth - kMainWidth
        let mainMargin:CGFloat = mainRemain / 2.0
        layoutMainLeft.constant = mainMargin
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionShare(sender button:UIButton)
    {
        controller.share()
    }
    
    //MARK: public
    
    func blocked()
    {
        alpha = kAlphaNotActive
        buttonShare.alpha = kAlphaNotActive
        isUserInteractionEnabled = false
        buttonShare.isUserInteractionEnabled = true
    }
    
    func partialBlocked()
    {
        alpha = kAlphaActive
        buttonShare.alpha = kAlphaNotActive
        isUserInteractionEnabled = true
        buttonShare.isUserInteractionEnabled = false
    }
    
    func notBlocked()
    {
        alpha = kAlphaActive
        buttonShare.alpha = kAlphaActive
        isUserInteractionEnabled = true
        buttonShare.isUserInteractionEnabled = true
    }
}
