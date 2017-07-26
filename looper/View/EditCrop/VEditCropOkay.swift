import UIKit

class VEditCropOkay:
    View<VEditCrop, MEditCrop, CEditCrop>
{
    required init(controller:CEditCrop)
    {
        super.init(controller:controller)
        
        let background:UIImageView = UIImageView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.clipsToBounds = true
        background.isUserInteractionEnabled = false
        background.contentMode = UIViewContentMode.center
        background.clipsToBounds = true
        background.image = #imageLiteral(resourceName: "assetGenericNext")
        
        let button:UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(
            String.localizedView(key:"VEditCropOkay_button"),
            for:UIControlState.normal)
        button.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        button.setTitleColor(
            UIColor(white:1, alpha:0.2),
            for:UIControlState.highlighted)
        button.titleLabel!.font = UIFont.medium(size:15)
        button.addTarget(
            self,
            action:#selector(actionOkay(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(background)
        addSubview(button)
        
        NSLayoutConstraint.equals(
            view:background,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:button,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionOkay(sender button:UIButton)
    {
        controller.okay()
    }
}
