import UIKit

class VEdit:ViewMain
{
    private weak var layoutSaveLeft:NSLayoutConstraint!
    private weak var layoutDeleteLeft:NSLayoutConstraint!
    private let kSaveWidth:CGFloat = 195
    private let kSaveTop:CGFloat = -32
    private let kSaveHeight:CGFloat = 64
    private let kDeleteWidth:CGFloat = 140
    private let kDeleteBottom:CGFloat = -20
    private let kDeleteHeight:CGFloat = 34
    private let kActionsHeight:CGFloat = 60
    private let kActionsBottom:CGFloat = -50
    private let kActionsMarginHorizontal:CGFloat = 40
    
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
        let remainDelete:CGFloat = width - kDeleteWidth
        let deleteMarginLeft:CGFloat = remainDelete / 2.0
        layoutBarHeight.constant = width
        layoutSaveLeft.constant = saveMarginLeft
        layoutDeleteLeft.constant = deleteMarginLeft
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionDelete(sender button:UIButton)
    {
        guard
        
            let controller:CEdit = self.controller as? CEdit
        
        else
        {
            return
        }
        
        controller.delete()
    }
    
    //MARK: private
    
    private func factoryViews(controller:CEdit)
    {
        let viewBar:VEditBar = VEditBar(controller:controller)
        
        let viewSave:VEditSave = VEditSave(controller:controller)
        
        let buttonDelete:UIButton = UIButton()
        buttonDelete.translatesAutoresizingMaskIntoConstraints = false
        buttonDelete.setTitleColor(
            UIColor.colourBackgroundDark,
            for:UIControlState.normal)
        buttonDelete.setTitleColor(
            UIColor.colourBackgroundGray,
            for:UIControlState.highlighted)
        buttonDelete.setTitle(
            String.localizedView(key:"VEdit_buttonDelete"),
            for:UIControlState.normal)
        buttonDelete.titleLabel!.font = UIFont.medium(size:15)
        buttonDelete.addTarget(
            self,
            action:#selector(actionDelete(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let viewActions:VEditActions = VEditActions(controller:controller)
        
        addSubview(viewBar)
        addSubview(buttonDelete)
        addSubview(viewSave)
        addSubview(viewActions)
        
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
            view:buttonDelete,
            toView:self,
            constant:kDeleteBottom)
        NSLayoutConstraint.height(
            view:buttonDelete,
            constant:kDeleteHeight)
        NSLayoutConstraint.width(
            view:buttonDelete,
            constant:kDeleteWidth)
        layoutDeleteLeft = NSLayoutConstraint.leftToLeft(
            view:buttonDelete,
            toView:self)
        
        NSLayoutConstraint.bottomToTop(
            view:viewActions,
            toView:buttonDelete,
            constant:kActionsBottom)
        NSLayoutConstraint.height(
            view:viewActions,
            constant:kActionsHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewActions,
            toView:self,
            margin:kActionsMarginHorizontal)
    }
}
