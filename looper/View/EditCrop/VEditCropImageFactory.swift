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
        
        let shadeBottom:VEditCropImageShade = VEditCropImageShade()
        shadeBottom.mask = viewMask
        self.shadeBottom = shadeBottom
        
        let shadeLeft:VEditCropImageShade = VEditCropImageShade()
        shadeLeft.mask = viewMask
        self.shadeLeft = shadeLeft
        
        let shadeRight:VEditCropImageShade = VEditCropImageShade()
        shadeRight.mask = viewMask
        self.shadeRight = shadeRight
        
        layoutPicture(viewPicture:viewPicture)
        layoutShadeTop(shade:shadeTop)
        layoutShadeBottom(shade:shadeBottom)
        layoutShadeLeft(shade:shadeLeft)
        layoutShadeRight(shade:shadeRight)
        layoutCorner(corner:cornerTopLeft)
        layoutCorner(corner:cornerTopRight)
        layoutCorner(corner:cornerBottomLeft)
        layoutCorner(corner:cornerBottomRight)
    }
    
    //MARK: private
    
    private func layoutPicture(viewPicture:VEditCropImagePicture)
    {
        addSubview(viewPicture)
        
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
    }
    
    private func layoutShadeTop(shade:VEditCropImageShade)
    {
        addSubview(shade)
        
        NSLayoutConstraint.topToTop(
            view:shade,
            toView:self)
        NSLayoutConstraint.bottomToTop(
            view:shade,
            toView:cornerTopLeft)
        NSLayoutConstraint.equalsHorizontal(
            view:shade,
            toView:self)
    }
    
    private func layoutShadeBottom(shade:VEditCropImageShade)
    {
        addSubview(shade)
        
        NSLayoutConstraint.topToBottom(
            view:shade,
            toView:cornerBottomLeft)
        NSLayoutConstraint.bottomToBottom(
            view:shade,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:shade,
            toView:self)
    }
    
    private func layoutShadeLeft(shade:VEditCropImageShade)
    {
        addSubview(shade)
        
        NSLayoutConstraint.equalsVertical(
            view:shade,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:shade,
            toView:self)
        NSLayoutConstraint.rightToLeft(
            view:shade,
            toView:cornerTopLeft)
    }
    
    private func layoutShadeRight(shade:VEditCropImageShade)
    {
        addSubview(shade)
        
        NSLayoutConstraint.equalsVertical(
            view:shade,
            toView:self)
        NSLayoutConstraint.leftToRight(
            view:shade,
            toView:cornerTopRight)
        NSLayoutConstraint.rightToRight(
            view:shade,
            toView:self)
    }
    
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
