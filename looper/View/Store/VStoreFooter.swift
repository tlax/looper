import UIKit

class VStoreFooter:UICollectionReusableView
{
    private weak var controller:CStore?
    private let kButtonHeight:CGFloat = 35
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let button:UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(
            UIColor(white:0.3, alpha:1),
            for:UIControlState.normal)
        button.setTitleColor(
            UIColor(white:0, alpha:0.2),
            for:UIControlState.highlighted)
        button.setTitle(
            NSLocalizedString("VStoreFooter_buttonRestore", comment:""),
            for:UIControlState.normal)
        button.titleLabel!.font = UIFont.medium(size:15)
        button.addTarget(
            self,
            action:#selector(actionRestore(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(button)
        
        let constraintsButton:[NSLayoutConstraint] = NSLayoutConstraint.equals(
            view:button,
            parent:self)
        
        addConstraints(constraintsButton)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: actions
    
    func actionRestore(sender button:UIButton)
    {
        controller?.restorePurchases()
    }
    
    //MARK: public
    
    func config(controller:CStore)
    {
        self.controller = controller
    }
}
