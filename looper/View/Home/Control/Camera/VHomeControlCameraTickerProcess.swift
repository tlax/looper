import UIKit

class VHomeControlCameraTickerProcess:UIView
{
    private let fillColor:UIColor
    private let strokeColor:UIColor
    private let kRadius:CGFloat = 25
    private let kStartAngle:CGFloat = 0.0001
    private let kEndAngle:CGFloat = 0
    private let kLineWidth:CGFloat = 5
    
    init()
    {
        fillColor = UIColor.black
        strokeColor = UIColor.genericLight
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func draw(_ rect:CGRect)
    {
        guard
        
            let context:CGContext = UIGraphicsGetCurrentContext()
        
        else
        {
            return
        }
        
        let width:CGFloat = rect.width
        let height:CGFloat = rect.height
        let width_2:CGFloat = width / 2.0
        let height_2:CGFloat = height / 2.0
        let center:CGPoint = CGPoint(
            x:width_2,
            y:height_2)
        
        context.setLineCap(CGLineCap.round)
        context.setLineWidth(kLineWidth)
        context.setFillColor(fillColor.cgColor)
        context.setStrokeColor(strokeColor.cgColor)
        context.addArc(
            center:center,
            radius:kRadius,
            startAngle:kStartAngle,
            endAngle:kEndAngle,
            clockwise:false)
        context.drawPath(using:CGPathDrawingMode.fill)
        context.addArc(
            center:center,
            radius:kRadius,
            startAngle:kStartAngle,
            endAngle:3,
            clockwise:false)
        context.drawPath(using:CGPathDrawingMode.stroke)
    }
}
