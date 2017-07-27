import UIKit

extension VEditCropImage
{
    func factoryViews()
    {
        let viewPicture:VEditCropImagePicture = VEditCropImagePicture(
            controller:controller)
        self.viewPicture = viewPicture
        
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
        
        addSubview(viewPicture)
        addSubview(shadeTop)
        
        layoutCorner(corner:cornerTopLeft)
        layoutCorner(corner:cornerTopRight)
        layoutCorner(corner:cornerBottomLeft)
        layoutCorner(corner:cornerBottomRight)
        
        viewPicture.layoutTop = NSLayoutConstraint.topToTop(
            view:viewPicture,
            toView:self)
        viewPicture.layoutBottom = NSLayoutConstraint.bottomToBottom(
            view:viewPicture,
            toView:self)
        viewPicture.layoutLeft = NSLayoutConstraint.leftToLeft(
            view:viewPicture,
            toView:self)
        viewPicture.layoutRight = NSLayoutConstraint.rightToRight(
            view:viewPicture,
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
