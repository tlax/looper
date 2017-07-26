import UIKit

class VEdit:ViewMain
{
    private weak var layoutSaveLeft:NSLayoutConstraint!
    private weak var layoutCancelLeft:NSLayoutConstraint!
    private let kSaveWidth:CGFloat = 195
    private let kSaveTop:CGFloat = -32
    private let kSaveHeight:CGFloat = 64
    private let kCancelWidth:CGFloat = 140
    private let kCancelBottom:CGFloat = -20
    private let kCancelHeight:CGFloat = 40
    private let kActionsHeight:CGFloat = 60
    private let kActionsBottom:CGFloat = 50
    
    private weak var layoutBarHeight:NSLayoutConstraint!
    
    required init(controller:UIViewController)
    {
        super.init(controller:controller)
        
        guard
        
            let controller:CEdit = controller as? CEdit
        
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
        let remainSave:CGFloat = width - kSaveWidth
        let saveMarginLeft:CGFloat = remainSave / 2.0
        let remainCancel:CGFloat = width - kCancelWidth
        let cancelMarginLeft:CGFloat = remainCancel / 2.0
        layoutBarHeight.constant = width
        layoutSaveLeft.constant = saveMarginLeft
        layoutCancelLeft.constant = cancelMarginLeft
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionCancel(sender button:UIButton)
    {
        
    }
    
    //MARK: private
    
    private func factoryViews(controller:CEdit)
    {
        let viewBar:VEditBar = VEditBar(controller:controller)
        
        let viewSave:VEditSave = VEditSave(controller:controller)
        
        let buttonCancel:UIButton = UIButton()
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        buttonCancel.setTitleColor(
            UIColor.colourBackgroundDark,
            for:UIControlState.normal)
        buttonCancel.setTitleColor(
            UIColor.colourBackgroundGray,
            for:UIControlState.highlighted)
        buttonCancel.setTitle(
            String.localizedView(key:"VEdit_buttonCancel"),
            for:UIControlState.normal)
        buttonCancel.titleLabel!.font = UIFont.regular(size:14)
        buttonCancel.addTarget(
            self,
            action:#selector(actionCancel(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(viewBar)
        addSubview(buttonCancel)
        addSubview(viewSave)
        
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        layoutBarHeight = NSLayoutConstraint.height(
            view:viewBar)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:viewSave,
            toView:viewBar,
            constant:kSaveTop)
        NSLayoutConstraint.height(
            view:viewSave,
            constant:kSaveHeight)
        NSLayoutConstraint.width(
            view:viewSave,
            constant:kSaveWidth)
        layoutSaveLeft = NSLayoutConstraint.leftToLeft(
            view:viewSave,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:buttonCancel,
            toView:self,
            constant:kCancelBottom)
        NSLayoutConstraint.height(
            view:buttonCancel,
            constant:kCancelHeight)
        NSLayoutConstraint.width(
            view:buttonCancel,
            constant:kCancelWidth)
        layoutCancelLeft = NSLayoutConstraint.leftToLeft(
            view:buttonCancel,
            toView:self)
    }
}
