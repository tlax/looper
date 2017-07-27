import UIKit

class VEditCropImageCornerTopLeft:VEditCropImageCorner
{
    override func drawWithContext(
        context:CGContext,
        width:CGFloat,
        height:CGFloat)
    {
        let initialPoint:CGPoint = CGPoint(
            x:lineWidth_2,
            y:height)
        let middlePoint:CGPoint = CGPoint(
            x:lineWidth_2,
            y:lineWidth_2)
        let endPoint:CGPoint = CGPoint(
            x:width,
            y:lineWidth_2)
        
        context.move(to:initialPoint)
        context.addLine(to:middlePoint)
        context.addLine(to:endPoint)
    }
}
