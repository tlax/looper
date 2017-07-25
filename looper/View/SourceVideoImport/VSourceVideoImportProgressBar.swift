import UIKit

class VSourceVideoImportProgressBar:
    View<VSourceVideoImport, MSourceVideoImport, CSourceVideoImport>
{
    private var percent:CGFloat
    private let colourSmall:UIColor
    private let colourBig:UIColor
    private let startAngle:CGFloat
    private let pi_2:CGFloat
    private let pi2:CGFloat
    private let endAngle:CGFloat
    private let kRadius:CGFloat = 82
    private let kSmallLineWidth:CGFloat = 2
    private let kBigLineWidth:CGFloat = 4
    
    required init(controller:CSourceVideoImport)
    {
        colourSmall = UIColor(white:0, alpha:0.15)
        colourBig = UIColor.white
        percent = 0
        pi2 = CGFloat.pi + CGFloat.pi
        pi_2 = CGFloat.pi / 2.0
        startAngle = -pi_2
        endAngle = -(pi_2 + 0.0001)
        
        super.init(controller:controller)
        isUserInteractionEnabled = false
    }
    
    required init?(coder:NSCoder)
    {
        return nil
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
        let centre:CGPoint = CGPoint(x:width_2, y:height_2)
        let endPercent:CGFloat = pi2 * percent
        let endAnglePercent:CGFloat = startAngle + endPercent
        
        context.setLineWidth(kSmallLineWidth)
        context.setStrokeColor(colourSmall.cgColor)
        context.addArc(
            center:centre,
            radius:kRadius,
            startAngle:startAngle,
            endAngle:endAngle,
            clockwise:false)
        context.drawPath(using:CGPathDrawingMode.stroke)
        
        context.setLineWidth(kBigLineWidth)
        context.setStrokeColor(colourBig.cgColor)
        context.addArc(
            center:centre,
            radius:kRadius,
            startAngle:startAngle,
            endAngle:endAnglePercent,
            clockwise:false)
        context.drawPath(using:CGPathDrawingMode.stroke)
    }
    
    //MARK: public
    
    func update(percent:CGFloat)
    {
        self.percent = percent
        setNeedsDisplay()
    }
}
