import UIKit

class VEditCrop:ViewMain
{
    private weak var layoutImageHeight:NSLayoutConstraint!
    
    required init(controller:UIViewController)
    {
        super.init(controller:controller)
        
        guard
        
            let controller:CEditCrop = controller as? CEditCrop
        
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
        layoutImageHeight.constant = width
        
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func factoryViews(controller:CEditCrop)
    {
        let viewImage:VEditCropImage = VEditCropImage(controller:controller)
        
        addSubview(viewImage)
        
        NSLayoutConstraint.topToTop(
            view:viewImage,
            toView:self)
        layoutImageHeight = NSLayoutConstraint.height(
            view:viewImage)
        NSLayoutConstraint.equalsHorizontal(
            view:viewImage,
            toView:self)
    }
}
