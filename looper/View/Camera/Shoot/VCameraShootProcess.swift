import UIKit

class VCameraShootProcess:UIView
{
    private weak var controller:CCameraShoot!
    private weak var label:UILabel!
    private var endAngle:CGFloat
    private let innerFillColor:UIColor
    private let strokeColor:UIColor
    private let borderColor:UIColor
    private let kRadius:CGFloat = 40
    private let kStartAngle:CGFloat = 0.0001
    private let kEndAngle:CGFloat = 6.28319
    private let kLineWidth:CGFloat = 12
    private let kBorderWidth:CGFloat = 14
    
    init(controller:CCameraShoot)
    {
        innerFillColor = UIColor.black
        strokeColor = UIColor.genericLight
        borderColor = UIColor.genericDark
        endAngle = kStartAngle
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.bold(size:20)
        label.textColor = UIColor.genericLight
        label.textAlignment = NSTextAlignment.center
        self.label = label
        
        addSubview(label)
        
        let constraintsLabel:[NSLayoutConstraint] = NSLayoutConstraint.equals(
            view:label,
            parent:self)
        
        addConstraints(constraintsLabel)
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
        context.setLineWidth(kBorderWidth)
        context.setStrokeColor(borderColor.cgColor)
        context.setFillColor(innerFillColor.cgColor)
        context.addArc(
            center:center,
            radius:kRadius,
            startAngle:kStartAngle,
            endAngle:kEndAngle,
            clockwise:false)
        context.drawPath(using:CGPathDrawingMode.fillStroke)
        context.setStrokeColor(strokeColor.cgColor)
        context.setLineWidth(kLineWidth)
        context.addArc(
            center:center,
            radius:kRadius,
            startAngle:kStartAngle,
            endAngle:endAngle,
            clockwise:false)
        context.drawPath(using:CGPathDrawingMode.stroke)
    }
    
    //MARK: public
    
    func update()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            guard
            
                let countShots:Int = MSession.sharedInstance.camera?.raw?.items.count,
                let startAngle:CGFloat = self?.kStartAngle,
                let endAngle:CGFloat = self?.kEndAngle
            
            else
            {
                return
            }
            
            let shotsString:String = "\(countShots)"
            
            if countShots >= MCamera.kMaxShots
            {
                self?.endAngle = endAngle
            }
            else
            {
                var percent:CGFloat = CGFloat(countShots) / CGFloat(MCamera.kMaxShots)
                
                if percent <= 0
                {
                    percent = startAngle
                }
                
                self?.endAngle = percent * endAngle
            }
            
            DispatchQueue.main.async
            { [weak self] in
                
                self?.label.text = shotsString
                self?.setNeedsDisplay()
            }
        }
    }
}
