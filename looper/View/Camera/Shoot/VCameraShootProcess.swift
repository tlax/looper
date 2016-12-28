import UIKit

class VCameraShootProcess:UIView
{
    private weak var controller:CCameraShoot!
    private weak var label:UILabel!
    private var endAngle:CGFloat
    private let innerFillColor:UIColor
    private let fillColor:UIColor
    private let strokeColor:UIColor
    private let kRadius:CGFloat = 30
    private let kStartAngle:CGFloat = 0.0001
    private let kEndAngle:CGFloat = 6.28319
    private let kBorderWidth:CGFloat = 16
    private let kLineWidth:CGFloat = 12
    private let kEmpty:String = "0"
    
    init(controller:CCameraShoot)
    {
        innerFillColor = UIColor.genericDark
        fillColor = UIColor.black
        strokeColor = UIColor.genericLight
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
        label.font = UIFont.bold(size:13)
        label.textColor = UIColor.genericLight
        label.textAlignment = NSTextAlignment.center
        label.text = kEmpty
        self.label = label
        
        addSubview(label)
        
        let layoutLabelTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:label,
            toView:self)
        let layoutLabelBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:label,
            toView:self)
        let layoutLabelLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:label,
            toView:self)
        let layoutLabelRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:label,
            toView:self)
        
        addConstraints([
            layoutLabelTop,
            layoutLabelBottom,
            layoutLabelLeft,
            layoutLabelRight])
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
        context.setStrokeColor(fillColor.cgColor)
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
    
    func update()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            /*
            guard
                
                let countPics:Int = controller.viewHome.viewControl.viewCamera?.model?.items.count
                
                else
            {
                timer.invalidate()
                
                return
            }
            
            label.text = "\(countPics)"
            
            if countPics >= kMaxPictures
            {
                controller.viewHome.viewControl.viewCamera?.viewMenu.buttonTrigger.stop()
                
                endAngle = kEndAngle
                timer.invalidate()
            }
            else
            {
                var percent:CGFloat = CGFloat(countPics) / CGFloat(kMaxPictures)
                
                if percent <= 0
                {
                    percent = kStartAngle
                }
                
                endAngle = percent * kEndAngle
            }
            
            setNeedsDisplay()*/
        }
    }
}
