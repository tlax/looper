import UIKit

class VEditCrop:ViewMain
{
    private weak var layoutImageHeight:NSLayoutConstraint!
    private weak var layoutOkayLeft:NSLayoutConstraint!
    private let kOkayWidth:CGFloat = 195
    private let kOkayBottom:CGFloat = -20
    private let kOkayHeight:CGFloat = 64
    
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
        let remainOkay:CGFloat = width - kOkayWidth
        let okayMarginLeft:CGFloat = remainOkay / 2.0
        layoutImageHeight.constant = width
        layoutOkayLeft.constant = okayMarginLeft
        
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func factoryViews(controller:CEditCrop)
    {
        let viewImage:VEditCropImage = VEditCropImage(controller:controller)
        
        let viewOkay:VEditCropOkay = VEditCropOkay(controller:controller)
        
        addSubview(viewImage)
        addSubview(viewOkay)
        
        NSLayoutConstraint.topToTop(
            view:viewImage,
            toView:self)
        layoutImageHeight = NSLayoutConstraint.height(
            view:viewImage)
        NSLayoutConstraint.equalsHorizontal(
            view:viewImage,
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
