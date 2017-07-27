import UIKit

extension VEditCropImage
{
    func factoryViews()
    {
        factoryPicture()
        factoryCorners()
        factoryShades()
    }
    
    //MARK: private
    
    private func factoryPicture()
    {
        let viewPicture:VEditCropImagePicture = VEditCropImagePicture(
            controller:controller)
        self.viewPicture = viewPicture
        
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
    
    private func factoryCorners()
    {
        let cornerTopLeft:VEditCropImageCornerTopLeft = VEditCropImageCornerTopLeft()
        self.cornerTopLeft = cornerTopLeft
        
        let cornerTopRight:VEditCropImageCornerTopRight = VEditCropImageCornerTopRight()
        self.cornerTopRight = cornerTopRight
        
        let cornerBottomLeft:VEditCropImageCornerBottomLeft = VEditCropImageCornerBottomLeft()
        self.cornerBottomLeft = cornerBottomLeft
        
        let cornerBottomRight:VEditCropImageCornerBottomRight = VEditCropImageCornerBottomRight()
        self.cornerBottomRight = cornerBottomRight
        
        layoutCorner(corner:cornerTopLeft)
        layoutCorner(corner:cornerTopRight)
        layoutCorner(corner:cornerBottomLeft)
        layoutCorner(corner:cornerBottomRight)
    }
    
    private func factoryShades()
    {
        let shadeTop:VEditCropImageShade = VEditCropImageShade()
        let shadeBottom:VEditCropImageShade = VEditCropImageShade()
        let shadeLeft:VEditCropImageShade = VEditCropImageShade()
        let shadeRight:VEditCropImageShade = VEditCropImageShade()
        
        layoutShadeTop(shade:shadeTop)
        layoutShadeBottom(shade:shadeBottom)
        layoutShadeLeft(shade:shadeLeft)
        layoutShadeRight(shade:shadeRight)
    }
    
    private func layoutShadeTop(shade:VEditCropImageShade)
    {
        insertSubview(shade, belowSubview:cornerTopLeft)
        
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
        insertSubview(shade, belowSubview:cornerTopLeft)
        
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
        insertSubview(shade, belowSubview:cornerTopLeft)
        
        NSLayoutConstraint.topToTop(
            view:shade,
            toView:cornerTopLeft)
        NSLayoutConstraint.bottomToBottom(
            view:shade,
            toView:cornerBottomLeft)
        NSLayoutConstraint.leftToLeft(
            view:shade,
            toView:self)
        NSLayoutConstraint.rightToLeft(
            view:shade,
            toView:cornerTopLeft)
    }
    
    private func layoutShadeRight(shade:VEditCropImageShade)
    {
        insertSubview(shade, belowSubview:cornerTopLeft)
        
        NSLayoutConstraint.topToTop(
            view:shade,
            toView:cornerTopRight)
        NSLayoutConstraint.bottomToBottom(
            view:shade,
            toView:cornerBottomRight)
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
