import UIKit

class VHomePlayerBoard:UIView
{
    private weak var controller:CHome!
    private weak var buttonMain:VHomePlayerBoardMain!
    private weak var layoutMainLeft:NSLayoutConstraint!
    private let kMainWidth:CGFloat = 70
    private let kButtonsHeight:CGFloat = 60
    
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
        
        addSubview(buttonMain)
        
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
        
        addConstraints([
            layoutMainHeight,
            layoutMainBottom,
            layoutMainLeft,
            layoutMainWidth])
    }
    
    override func layoutSubviews()
    {
        let totalWidth:CGFloat = bounds.maxX
        let mainRemain:CGFloat = totalWidth - kMainWidth
        let mainMargin:CGFloat = mainRemain / 2.0
        layoutMainLeft.constant = mainMargin
        
        super.layoutSubviews()
    }
}
