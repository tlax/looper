import UIKit

extension VEditCropImage
{
    func constraintImage()
    {
        guard
            
            let image:UIImage = self.image
            
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
        
        layoutImageRight.constant = -marginWidth
        layoutImageLeft.constant = marginWidth
        layoutImageTop.constant = marginHeight
        layoutImageBottom.constant = -marginHeight
        
        constraintCorners()
    }
    
    //MARK: private
    
    private func constraintCorners()
    {
        viewCornerTopLeft.layoutTop.constant = layoutImageTop.constant
        viewCornerTopLeft.layoutLeft.constant = layoutImageLeft.constant
    }
}
