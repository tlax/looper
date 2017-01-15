import UIKit

class VCameraRotateHandler:UIView
{
    private var colorRad:UIColor
    private var colorDisp:UIColor
    private var centerArc:CGPoint
    private var radius:CGFloat
    private var dispRadius:CGFloat
    private var dispInit:CGFloat
    private var dispEnd:CGFloat
    private let kDispRadMargin:CGFloat = 20
    private let kMargin:CGFloat = 50
    private let kZeroRad:CGFloat = -CGFloat(M_PI_2)
    private let k360Rad:CGFloat = CGFloat(M_PI + M_PI_2)
    private let kDeltaRad:CGFloat = 0.05
    private let kRadSize:CGFloat = 0.01
    private let kRadLineWidth:CGFloat = 10
    private let kDispLineWidth:CGFloat = 20
    
    init()
    {
        colorRad = UIColor(white:0, alpha:0.6)
        colorDisp = UIColor.genericLight
        dispInit = kZeroRad
        dispEnd = kZeroRad
        radius = 0
        dispRadius = 0
        centerArc = CGPoint.zero
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let centerX:CGFloat = bounds.midX
        let centerY:CGFloat = bounds.midY
        let minSize:CGFloat = min(centerX, centerY)
        radius = minSize - kMargin
        dispRadius = radius + kDispRadMargin
        centerArc = CGPoint(x:centerX, y:centerY)
        
        super.layoutSubviews()
    }
    
    override func draw(_ rect:CGRect)
    {
        guard
        
            let context:CGContext = UIGraphicsGetCurrentContext()
        
        else
        {
            return
        }
        
        context.setLineCap(CGLineCap.butt)
        context.setLineWidth(kRadLineWidth)
        context.setStrokeColor(colorRad.cgColor)
        
        var currentRad:CGFloat = kZeroRad
        
        while currentRad < k360Rad
        {
            let initial:CGFloat = currentRad
            currentRad += kRadSize
            let end:CGFloat = currentRad
            currentRad += kDeltaRad
            
            context.addArc(
                center:centerArc,
                radius:radius,
                startAngle:initial,
                endAngle:end,
                clockwise:false)
            
            context.drawPath(using:CGPathDrawingMode.stroke)
        }
        
        context.setLineCap(CGLineCap.round)
        context.setLineWidth(kDispLineWidth)
        context.setStrokeColor(colorDisp.cgColor)
        context.addArc(
            center:centerArc,
            radius:dispRadius,
            startAngle:dispInit,
            endAngle:dispEnd,
            clockwise:false)
        
        context.drawPath(using:CGPathDrawingMode.stroke)
    }
}
