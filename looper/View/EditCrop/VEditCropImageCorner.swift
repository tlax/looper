import UIKit

class VEditCropImageCorner:UIView
{
    weak var layoutTop:NSLayoutConstraint!
    weak var layoutLeft:NSLayoutConstraint!
    var previousTouch:CGPoint?
    let lineWidth_2:CGFloat
    private(set) var initialX:CGFloat
    private(set) var initialY:CGFloat
    private let colourStroke:UIColor
    private let kLineWidth:CGFloat = 4
    
    init()
    {
        colourStroke = UIColor.white
        lineWidth_2 = kLineWidth / 2.0
        initialX = 0
        initialY = 0
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
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
        
        context.setLineWidth(kLineWidth)
        context.setStrokeColor(colourStroke.cgColor)
        drawWithContext(
            context:context,
            width:width,
            height:height)
        context.drawPath(using:CGPathDrawingMode.stroke)
    }
    
    //MARK: public
    
    func drawWithContext(
        context:CGContext,
        width:CGFloat,
        height:CGFloat)
    {
    }
    
    func layout(initialX:CGFloat, initialY:CGFloat)
    {
        self.initialX = initialX
        self.initialY = initialY
        
        reset()
    }
    
    func reset()
    {
        layoutLeft.constant = initialX
        layoutTop.constant = initialY
    }
}
