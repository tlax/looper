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
        
        layoutPicture(viewPicture:viewPicture)
        layoutShade(shade:shadeTop)
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
    
    private func layoutShade(shade:VEditCropImageShade)
    {
        addSubview(shade)
        
        shade.layoutTop = NSLayoutConstraint.topToTop(
            view:shade,
            toView:self)
        shade.layoutBottom = NSLayoutConstraint.bottomToBottom(
            view:shade,
            toView:self)
        shade.layoutLeft = NSLayoutConstraint.leftToLeft(
            view:shade,
            toView:self)
        shade.layoutRight = NSLayoutConstraint.rightToRight(
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
