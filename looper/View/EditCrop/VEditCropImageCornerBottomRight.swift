import UIKit

class VEditCropImageCornerBottomRight:VEditCropImageCorner
{
    override func drawWithContext(
        context:CGContext,
        width:CGFloat,
        height:CGFloat)
    {
        let maxX:CGFloat = width - lineWidth_2
        let maxY:CGFloat = height - lineWidth_2
        
        let initialPoint:CGPoint = CGPoint(
            x:maxX,
            y:0)
        let middlePoint:CGPoint = CGPoint(
            x:maxX,
            y:maxY)
        let endPoint:CGPoint = CGPoint(
            x:0,
            y:maxY)
        
        context.move(to:initialPoint)
        context.addLine(to:middlePoint)
        context.addLine(to:endPoint)
    }
}
