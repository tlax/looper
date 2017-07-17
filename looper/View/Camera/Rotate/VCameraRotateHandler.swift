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
    private var deltaSpectrum:CGFloat
    private var movingClockWise:Bool
    private let kDispRadMargin:CGFloat = 16
    private let kMargin:CGFloat = 50
    private let kZeroRad:CGFloat = -CGFloat.pi / -2
    private let k360Rad:CGFloat = CGFloat.pi + (CGFloat.pi / 2)
    private let kDeltaRad:CGFloat = 0.02
    private let kRadSize:CGFloat = 0.015
    private let kRadLineWidth:CGFloat = 10
    private let kDispLineWidth:CGFloat = 20
    
    init()
    {
        colorRad = UIColor(white:0, alpha:0.15)
        colorDisp = UIColor.genericLight
        dispInit = kZeroRad
        dispEnd = kZeroRad
        deltaSpectrum = k360Rad - kZeroRad
        radius = 0
        dispRadius = 0
        centerArc = CGPoint.zero
        movingClockWise = false
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder:NSCoder)
    {
        return nil
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
        
        let maxEndAntiClock:CGFloat = k360Rad + dispEnd - dispInit
        var currentRad:CGFloat = kZeroRad
        
        while currentRad < k360Rad
        {
            let initial:CGFloat = currentRad
            currentRad += kRadSize
            let end:CGFloat = currentRad
            currentRad += kDeltaRad
            
            if movingClockWise
            {
                if end >= maxEndAntiClock
                {
                    context.setStrokeColor(colorDisp.cgColor)
                }
                else
                {
                    context.setStrokeColor(colorRad.cgColor)
                }
            }
            else
            {
                if end <= dispEnd
                {
                    context.setStrokeColor(colorDisp.cgColor)
                }
                else
                {
                    context.setStrokeColor(colorRad.cgColor)
                }
            }
            
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
            clockwise:movingClockWise)
        
        context.drawPath(using:CGPathDrawingMode.stroke)
    }
    
    //MARK: public
    
    func handRight(delta:CGFloat)
    {
        movingClockWise = false
        dispEnd = (delta * deltaSpectrum) + dispInit
        setNeedsDisplay()
    }
    
    func handLeft(delta:CGFloat)
    {
        movingClockWise = true
        dispEnd = (delta * -deltaSpectrum) + dispInit
        setNeedsDisplay()
    }
}
