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
        
        let viewMask:VEditCropImageMask = VEditCropImageMask()
        self.viewMask = viewMask
        
        let cornerTopLeft:VEditCropImageCornerTopLeft = VEditCropImageCornerTopLeft()
        self.cornerTopLeft = cornerTopLeft
        
        let cornerTopRight:VEditCropImageCornerTopRight = VEditCropImageCornerTopRight()
        self.cornerTopRight = cornerTopRight
        
        let cornerBottomLeft:VEditCropImageCornerBottomLeft = VEditCropImageCornerBottomLeft()
        self.cornerBottomLeft = cornerBottomLeft
        
        let cornerBottomRight:VEditCropImageCornerBottomRight = VEditCropImageCornerBottomRight()
        self.cornerBottomRight = cornerBottomRight
        
        let shadeTop:VEditCropImageShade = VEditCropImageShade()
        shadeTop.mask = viewMask
        self.shadeTop = shadeTop
        
        addSubview(imageView)
        addSubview(shadeTop)
        
        layoutCorner(corner:cornerTopLeft)
        layoutCorner(corner:cornerTopRight)
        layoutCorner(corner:cornerBottomLeft)
        layoutCorner(corner:cornerBottomRight)
        
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
        
        NSLayoutConstraint.topToTop(
            view:shadeTop,
            toView:self)
        NSLayoutConstraint.bottomToBottom(
            view:shadeTop,
            toView:self,
            constant:-100)
        NSLayoutConstraint.leftToLeft(
            view:shadeTop,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:shadeTop,
            toView:self)
        
        guard
            
            let cgImage:CGImage = controller.model.edit.sequence?.items.first?.image
            
        else
        {
            return
        }
        
        image = UIImage(cgImage:cgImage)
        imageView.image = image
    }
    
    //MARK: private
    
    private func layoutCorner(corner:VEditCropImageCorner)
    {
        addSubview(corner)
        
        corner.layoutTop = NSLayoutConstraint.topToTop(
            view:corner,
            toView:self)
        corner.layoutLeft = NSLayoutConstraint.leftToLeft(
            view:corner,
            toView:self)
        NSLayoutConstraint.size(
            view:corner,
            constant:kCornerSize)
    }
}
