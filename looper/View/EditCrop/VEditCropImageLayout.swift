import UIKit

extension VEditCropImage
{
    func layout()
    {
        constraintImage()
        constraintCorners()
        factoryBorders()
    }
    
    //MARK: private
    
    private func constraintImage()
    {
        guard
            
            let image:UIImage = viewPicture.image
            
        else
        {
            return
        }
        
        let canvasWidth:CGFloat = bounds.width
        let canvasHeight:CGFloat = bounds.height
        let usableWidth:CGFloat = canvasWidth - imageMargin2
        let usableHeight:CGFloat = canvasHeight - imageMargin2
        let width:CGFloat = image.size.width
        let height:CGFloat = image.size.height
        let deltaWidth:CGFloat = width / usableWidth
        let deltaHeight:CGFloat = height / usableHeight
        let maxDelta:CGFloat = max(deltaWidth, deltaHeight)
        let ratioWidth:CGFloat = width / maxDelta
        let ratioHeight:CGFloat = height / maxDelta
        let remainWidth:CGFloat = canvasWidth - ratioWidth
        let remainHeight:CGFloat = canvasHeight - ratioHeight
        let marginWidth:CGFloat = remainWidth / 2.0
        let marginHeight:CGFloat = remainHeight / 2.0
        
        viewPicture.layoutRight.constant = -marginWidth
        viewPicture.layoutLeft.constant = marginWidth
        viewPicture.layoutTop.constant = marginHeight
        viewPicture.layoutBottom.constant = -marginHeight
        
        constraintCorners()
    }
    
    private func constraintCorners()
    {
        let canvasWidth:CGFloat = bounds.width
        let canvasHeight:CGFloat = bounds.height
        let minX:CGFloat = viewPicture.layoutLeft.constant
        let minY:CGFloat = viewPicture.layoutTop.constant
        let maxX:CGFloat = canvasWidth + viewPicture.layoutRight.constant - kCornerSize
        let maxY:CGFloat = canvasHeight + viewPicture.layoutBottom.constant - kCornerSize
        
        cornerTopLeft.layout(
            initialX:minX,
            initialY:minY)
        cornerTopRight.layout(
            initialX:maxX,
            initialY:minY)
        cornerBottomLeft.layout(
            initialX:minX,
            initialY:maxY)
        cornerBottomRight.layout(
            initialX:maxX,
            initialY:maxY)
    }
    
    private func factoryBorders()
    {
        let colour:UIColor = UIColor(white:1, alpha:0.5)
        
        let borderTop:VBorder = VBorder(colour:colour)
        let borderBottom:VBorder = VBorder(colour:colour)
        let borderLeft:VBorder = VBorder(colour:colour)
        let borderRight:VBorder = VBorder(colour:colour)
        
        layoutBorderTop(border:borderTop)
        layoutBorderBottom(border:borderBottom)
        layoutBorderLeft(border:borderLeft)
        layoutBorderRight(border:borderRight)
    }
    
    private func layoutBorderTop(border:VBorder)
    {
        addSubview(border)
        
        NSLayoutConstraint.bottomToTop(
            view:border,
            toView:cornerTopLeft)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderWidth)
        NSLayoutConstraint.leftToRight(
            view:border,
            toView:cornerTopLeft)
        NSLayoutConstraint.rightToLeft(
            view:border,
            toView:cornerTopRight)
    }
    
    private func layoutBorderBottom(border:VBorder)
    {
        addSubview(border)
        
        NSLayoutConstraint.topToBottom(
            view:border,
            toView:cornerBottomLeft)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderWidth)
        NSLayoutConstraint.leftToRight(
            view:border,
            toView:cornerBottomLeft)
        NSLayoutConstraint.rightToLeft(
            view:border,
            toView:cornerBottomRight)
    }
    
    private func layoutBorderLeft(border:VBorder)
    {
        addSubview(border)
        
        NSLayoutConstraint.topToBottom(
            view:border,
            toView:cornerTopLeft)
        NSLayoutConstraint.bottomToTop(
            view:border,
            toView:cornerBottomLeft)
        NSLayoutConstraint.rightToLeft(
            view:border,
            toView:cornerTopLeft)
        NSLayoutConstraint.width(
            view:border,
            constant:kBorderWidth)
    }
    
    private func layoutBorderRight(border:VBorder)
    {
        addSubview(border)
        
        NSLayoutConstraint.topToBottom(
            view:border,
            toView:cornerTopRight)
        NSLayoutConstraint.bottomToTop(
            view:border,
            toView:cornerBottomRight)
        NSLayoutConstraint.leftToRight(
            view:border,
            toView:cornerTopRight)
        NSLayoutConstraint.width(
            view:border,
            constant:kBorderWidth)
    }
}
