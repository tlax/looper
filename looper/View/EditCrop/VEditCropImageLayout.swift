import UIKit

extension VEditCropImage
{
    func constraintImage()
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
        layoutIfNeeded()
        viewMask.frame = viewPicture.frame
    }
    
    //MARK: private
    
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
}
