import UIKit

extension VEditCropImage
{
    func factoryViews()
    {
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.layer.borderWidth = kImageBorderWidth
        imageView.layer.borderColor = UIColor(white:1, alpha:0.5).cgColor
        
        let viewCornerTopLeft:VEditCropImageCornerTopLeft = VEditCropImageCornerTopLeft()
        self.viewCornerTopLeft = viewCornerTopLeft
        
        addSubview(imageView)
        addSubview(viewCornerTopLeft)
        
        layoutImageTop = NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self)
        layoutImageBottom = NSLayoutConstraint.bottomToBottom(
            view:imageView,
            toView:self)
        layoutImageLeft = NSLayoutConstraint.leftToLeft(
            view:imageView,
            toView:self)
        layoutImageRight = NSLayoutConstraint.rightToRight(
            view:imageView,
            toView:self)
        
        viewCornerTopLeft.layoutTop = NSLayoutConstraint.topToTop(
            view:viewCornerTopLeft,
            toView:self)
        viewCornerTopLeft.layoutLeft = NSLayoutConstraint.leftToLeft(
            view:viewCornerTopLeft,
            toView:self)
        NSLayoutConstraint.size(
            view:viewCornerTopLeft,
            constant:kCornerSize)
        
        guard
            
            let cgImage:CGImage = controller.model.edit.sequence?.items.first?.image
            
        else
        {
            return
        }
        
        image = UIImage(cgImage:cgImage)
        imageView.image = image
    }
}
