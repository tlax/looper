import UIKit

class VEditCropImageCornerBottomLeft:VEditCropImageCorner
{
    override func drawWithContext(
        context:CGContext,
        width:CGFloat,
        height:CGFloat)
    {
        let maxY:CGFloat = height - lineWidth_2
        
        let initialPoint:CGPoint = CGPoint(
            x:lineWidth_2,
            y:0)
        let middlePoint:CGPoint = CGPoint(
            x:lineWidth_2,
            y:maxY)
        let endPoint:CGPoint = CGPoint(
            x:width,
            y:maxY)
        
        context.move(to:initialPoint)
        context.addLine(to:middlePoint)
        context.addLine(to:endPoint)
    }
}
