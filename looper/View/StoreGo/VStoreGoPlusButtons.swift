import UIKit

class VStoreGoPlusButtons:UIView
{
    private weak var controller:CStoreGoPlus!
    private let kButtonMargin:CGFloat = 1
    private let kButtonWidth:CGFloat = 148
    
    convenience init(controller:CStoreGoPlus)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.genericBackground
        self.controller = controller
        
        let buttonStore:UIButton = UIButton()
        buttonStore.translatesAutoresizingMaskIntoConstraints = false
        buttonStore.clipsToBounds = true
        buttonStore.backgroundColor = UIColor.white
        buttonStore.setTitle(
            NSLocalizedString("VStoreGoPlusButtons_buttonStore", comment:""),
            for:UIControlState.normal)
        buttonStore.setTitleColor(
            UIColor.genericLight,
            for:UIControlState.normal)
        buttonStore.setTitleColor(
            UIColor(white:0, alpha:0.1),
            for:UIControlState.highlighted)
        buttonStore.titleLabel!.font = UIFont.medium(size:15)
        buttonStore.addTarget(
            self,
            action:#selector(actionStore(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonCancel:UIButton = UIButton()
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        buttonCancel.clipsToBounds = true
        buttonCancel.backgroundColor = UIColor.white
        buttonCancel.setTitle(
            NSLocalizedString("VStoreGoPlusButtons_buttonCancel", comment:""),
            for:UIControlState.normal)
        buttonCancel.setTitleColor(
            UIColor(white:0.6, alpha:1),
            for:UIControlState.normal)
        buttonCancel.setTitleColor(
            UIColor(white:0, alpha:0.1),
            for:UIControlState.highlighted)
        buttonCancel.titleLabel!.font = UIFont.medium(size:15)
        buttonCancel.addTarget(
            self,
            action:#selector(self.actionCancel(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(buttonStore)
        addSubview(buttonCancel)
        
        let layoutButtonCancelTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:buttonCancel,
            toView:self,
            constant:kButtonMargin)
        let layoutButtonCancelBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:buttonCancel,
            toView:self)
        let layoutButtonCancelLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:buttonCancel,
            toView:self,
            constant:kButtonMargin)
        let layoutButtonCancelWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:buttonCancel,
            constant:kButtonWidth)
        
        let layoutButtonStoreTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:buttonStore,
            toView:self,
            constant:kButtonMargin)
        let layoutButtonStoreBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:buttonStore,
            toView:self)
        let layoutButtonStoreRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:buttonStore,
            toView:self,
            constant:-kButtonMargin)
        let layoutButtonStoreWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:buttonStore,
            constant:kButtonWidth)
        
        addConstraints([
            layoutButtonCancelTop,
            layoutButtonCancelBottom,
            layoutButtonCancelLeft,
            layoutButtonCancelWidth,
            layoutButtonStoreTop,
            layoutButtonStoreBottom,
            layoutButtonStoreRight,
            layoutButtonStoreWidth])
    }
    
    //MARK: actions
    
    func actionStore(sender button:UIButton)
    {
        controller.openStore()
    }
    
    func actionCancel(sender button:UIButton)
    {
        controller.close()
    }
}
