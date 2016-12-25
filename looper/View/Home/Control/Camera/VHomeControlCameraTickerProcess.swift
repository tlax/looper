import UIKit

class VHomeControlCameraTickerProcess:UIView
{
    private weak var controller:CHome!
    private weak var label:UILabel!
    private weak var timer:Timer?
    private var endAngle:CGFloat
    private let fillColor:UIColor
    private var strokeColor:UIColor
    private let kRadius:CGFloat = 32
    private let kStartAngle:CGFloat = 0.0001
    private let kEndAngle:CGFloat = 6.28319
    private let kBorderWidth:CGFloat = 16
    private let kLineWidth:CGFloat = 12
    private let kTimerInterval:TimeInterval = 0.1
    private let kMaxPictures:Int = 200
    
    init(controller:CHome)
    {
        fillColor = UIColor.black
        strokeColor = UIColor.genericDark
        endAngle = kEndAngle
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.medium(size:12)
        label.textColor = UIColor.genericLight
        label.textAlignment = NSTextAlignment.center
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
    
    deinit
    {
        timer?.invalidate()
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
        context.addArc(
            center:center,
            radius:kRadius,
            startAngle:kStartAngle,
            endAngle:kEndAngle,
            clockwise:false)
        context.drawPath(using:CGPathDrawingMode.stroke)
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
    
    func tick(sender timer:Timer)
    {
        guard
            
            let countPics:Int = controller.viewHome.viewControl.viewCamera?.model?.items.count
        
        else
        {
            timer.invalidate()
            
            return
        }
        
        if countPics >= kMaxPictures
        {
            controller.viewHome.viewControl.viewCamera?.viewMenu.buttonTrigger.stop()
            
            strokeColor = UIColor.genericDark
            endAngle = kEndAngle
            timer.invalidate()
        }
        else
        {
            strokeColor = UIColor.genericLight
            var percent:CGFloat = CGFloat(countPics) / CGFloat(kMaxPictures)
            
            if percent <= 0
            {
                percent = kStartAngle
            }
            
            endAngle = percent * kEndAngle
        }
            
        setNeedsDisplay()
    }
    
    //MARK: public
    
    func start()
    {
        timer?.invalidate()

        timer = Timer.scheduledTimer(
            timeInterval:kTimerInterval,
            target:self,
            selector:#selector(self.tick(sender:)),
            userInfo:nil,
            repeats:true)
    }
    
    func clean()
    {
        strokeColor = UIColor.genericDark
        timer?.invalidate()
    }
}
