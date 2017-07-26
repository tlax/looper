import UIKit

class VEditDuration:ViewMain
{
    private weak var layoutOkayLeft:NSLayoutConstraint!
    private let kOkayWidth:CGFloat = 195
    private let kOkayBottom:CGFloat = -20
    private let kOkayHeight:CGFloat = 64
    private let kCollectionHeight:CGFloat = 60
    private let kTitlesHeight:CGFloat = 35
    private let kTitleTop:CGFloat = 50
    private let kTitleMinutesTop:CGFloat = 20
    private let kTitleSecondsTop:CGFloat = 50
    
    required init(controller:UIViewController)
    {
        super.init(controller:controller)
        
        guard
        
            let controller:CEditDuration = controller as? CEditDuration
        
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
        layoutOkayLeft.constant = okayMarginLeft
        
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func factoryViews(controller:CEditDuration)
    {
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.textColor = UIColor.colourBackgroundDark
        labelTitle.font = UIFont.medium(size:18)
        labelTitle.text = String.localizedView(
            key:"VEditDuration_labelTitle")
        
        let labelMinutes:UILabel = UILabel()
        labelMinutes.isUserInteractionEnabled = false
        labelMinutes.translatesAutoresizingMaskIntoConstraints = false
        labelMinutes.backgroundColor = UIColor.clear
        labelMinutes.textAlignment = NSTextAlignment.center
        labelMinutes.textColor = UIColor(white:0, alpha:0.3)
        labelMinutes.font = UIFont.medium(size:18)
        labelMinutes.text = String.localizedView(
            key:"VEditDuration_labelMinutes")
        
        let viewMinutes:VEditDurationMinutes = VEditDurationMinutes(
            controller:controller)
        
        let viewOkay:VEditDurationOkay = VEditDurationOkay(
            controller:controller)
        
        addSubview(labelTitle)
        addSubview(labelMinutes)
        addSubview(viewMinutes)
        addSubview(viewOkay)
        
        NSLayoutConstraint.topToTop(
            view:labelTitle,
            toView:self,
            constant:kTitleTop)
        NSLayoutConstraint.height(
            view:labelTitle,
            constant:kTitlesHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:labelMinutes,
            toView:labelTitle,
            constant:kTitleMinutesTop)
        NSLayoutConstraint.height(
            view:labelMinutes,
            constant:kTitlesHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelMinutes,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:viewMinutes,
            toView:labelMinutes)
        NSLayoutConstraint.height(
            view:viewMinutes,
            constant:kCollectionHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewMinutes,
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
}
