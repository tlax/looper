import UIKit

class VEditCropImageCornerTopRight:VEditCropImageCorner
{
    override func drawWithContext(
        context:CGContext,
        width:CGFloat,
        height:CGFloat)
    {
        let maxX:CGFloat = width - lineWidth_2
        
        let initialPoint:CGPoint = CGPoint(
            x:maxX,
            y:height)
        let middlePoint:CGPoint = CGPoint(
            x:maxX,
            y:lineWidth_2)
        let endPoint:CGPoint = CGPoint(
            x:0,
            y:lineWidth_2)
        
        context.move(to:initialPoint)
        context.addLine(to:middlePoint)
        context.addLine(to:endPoint)
    }
}
