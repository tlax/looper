import UIKit

class VEditDuration:ViewMain
{
    private(set) weak var viewDisplay:VEditDurationDisplay!
    private weak var viewMinutes:VEditDurationMinutes!
    private weak var viewSeconds:VEditDurationSeconds!
    private weak var layoutOkayLeft:NSLayoutConstraint!
    private let kOkayWidth:CGFloat = 195
    private let kOkayBottom:CGFloat = -20
    private let kOkayHeight:CGFloat = 64
    private let kCollectionHeight:CGFloat = 80
    private let kMainTitleHeight:CGFloat = 25
    private let kTitlesHeight:CGFloat = 22
    private let kTitleTop:CGFloat = 30
    private let kTitleMinutesTop:CGFloat = 8
    private let kTitleSecondsTop:CGFloat = 8
    private let kDisplayHeight:CGFloat = 200
    
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
        labelTitle.font = UIFont.bold(size:20)
        labelTitle.text = String.localizedView(
            key:"VEditDuration_labelTitle")
        
        let labelMinutes:UILabel = UILabel()
        labelMinutes.isUserInteractionEnabled = false
        labelMinutes.translatesAutoresizingMaskIntoConstraints = false
        labelMinutes.backgroundColor = UIColor.clear
        labelMinutes.textAlignment = NSTextAlignment.center
        labelMinutes.textColor = UIColor.colourBackgroundDark.withAlphaComponent(0.5)
        labelMinutes.font = UIFont.medium(size:18)
        labelMinutes.text = String.localizedView(
            key:"VEditDuration_labelMinutes")
        
        let labelSeconds:UILabel = UILabel()
        labelSeconds.isUserInteractionEnabled = false
        labelSeconds.translatesAutoresizingMaskIntoConstraints = false
        labelSeconds.backgroundColor = UIColor.clear
        labelSeconds.textAlignment = NSTextAlignment.center
        labelSeconds.textColor = UIColor.colourBackgroundDark.withAlphaComponent(0.5)
        labelSeconds.font = UIFont.medium(size:18)
        labelSeconds.text = String.localizedView(
            key:"VEditDuration_labelSeconds")
        
        let viewDisplay:VEditDurationDisplay = VEditDurationDisplay(
            controller:controller)
        self.viewDisplay = viewDisplay
        
        let viewMinutes:VEditDurationMinutes = VEditDurationMinutes(
            controller:controller)
        self.viewMinutes = viewMinutes
        
        let viewSeconds:VEditDurationSeconds = VEditDurationSeconds(
            controller:controller)
        self.viewSeconds = viewSeconds
        
        let viewOkay:VEditDurationOkay = VEditDurationOkay(
            controller:controller)
        
        addSubview(labelTitle)
        addSubview(labelMinutes)
        addSubview(labelSeconds)
        addSubview(viewDisplay)
        addSubview(viewMinutes)
        addSubview(viewSeconds)
        addSubview(viewOkay)
        
        NSLayoutConstraint.topToTop(
            view:labelTitle,
            toView:self,
            constant:kTitleTop)
        NSLayoutConstraint.height(
            view:labelTitle,
            constant:kMainTitleHeight)
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
            view:labelSeconds,
            toView:viewMinutes,
            constant:kTitleSecondsTop)
        NSLayoutConstraint.height(
            view:labelSeconds,
            constant:kTitlesHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelSeconds,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:viewDisplay,
            toView:viewSeconds)
        NSLayoutConstraint.height(
            view:viewDisplay,
            constant:kDisplayHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewDisplay,
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
        
        NSLayoutConstraint.topToBottom(
            view:viewSeconds,
            toView:labelSeconds)
        NSLayoutConstraint.height(
            view:viewSeconds,
            constant:kCollectionHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewSeconds,
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
        viewMinutes.selectCurrent()
        viewSeconds.selectCurrent()
        viewDisplay.update()
    }
}
