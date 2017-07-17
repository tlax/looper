import UIKit

class VCameraPreviewPlayerTimerSlider:UIView
{
    private weak var controller:CCameraPreview!
    private weak var viewThumb:UIImageView!
    private weak var layoutTrackTop:NSLayoutConstraint!
    private weak var layoutTrackWidth:NSLayoutConstraint!
    private weak var layoutThumbLeft:NSLayoutConstraint!
    private weak var layoutInsideTrackWidth:NSLayoutConstraint!
    private var usableWidth:CGFloat
    private let timeSpan:TimeInterval
    private let thumbWidth_2:CGFloat
    private let kMinTime:TimeInterval = 1
    private let kMaxTime:TimeInterval = 30
    private let kTrackHeight:CGFloat = 2
    private let kThumbWidth:CGFloat = 40
    
    init(controller:CCameraPreview)
    {
        usableWidth = 0
        timeSpan = kMaxTime - kMinTime
        thumbWidth_2 = kThumbWidth / 2.0
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let track:UIView = UIView()
        track.isUserInteractionEnabled = false
        track.translatesAutoresizingMaskIntoConstraints = false
        track.clipsToBounds = true
        track.backgroundColor = UIColor(white:0.94, alpha:1)
        track.layer.cornerRadius = kTrackHeight / 2.0
        
        let insideTrack:UIView = UIView()
        insideTrack.isUserInteractionEnabled = false
        insideTrack.clipsToBounds = true
        insideTrack.backgroundColor = UIColor.genericLight
        insideTrack.translatesAutoresizingMaskIntoConstraints = false
        
        let viewThumb:UIImageView = UIImageView()
        viewThumb.isUserInteractionEnabled = true
        viewThumb.translatesAutoresizingMaskIntoConstraints = false
        viewThumb.clipsToBounds = true
        viewThumb.contentMode = UIViewContentMode.center
        self.viewThumb = viewThumb
        
        track.addSubview(insideTrack)
        addSubview(track)
        addSubview(viewThumb)
        
        NSLayoutConstraint.equalsVertical(
            view:viewThumb,
            toView:self)
        NSLayoutConstraint.width(
            view:viewThumb,
            constant:kThumbWidth)
        layoutThumbLeft = NSLayoutConstraint.leftToLeft(
            view:viewThumb,
            toView:self)
        
        NSLayoutConstraint.equalsVertical(
            view:insideTrack,
            toView:track)
        NSLayoutConstraint.leftToLeft(
            view:insideTrack,
            toView:track)
        layoutInsideTrackWidth = NSLayoutConstraint.width(
            view:insideTrack)
        
        layoutTrackTop = NSLayoutConstraint.topToTop(
            view:track,
            toView:self)
        NSLayoutConstraint.height(
            view:track,
            constant:kTrackHeight)
        NSLayoutConstraint.leftToLeft(
            view:track,
            toView:self,
            constant:thumbWidth_2)
        layoutTrackWidth = NSLayoutConstraint.width(
            view:track)

        thumbNormal()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let height:CGFloat = bounds.maxY
        let remainHeight:CGFloat = height - kTrackHeight
        usableWidth = width - kThumbWidth
        let marginTop:CGFloat = remainHeight / 2.0
        
        let addedTime:TimeInterval = controller.currentTime - kMinTime
        let percentage:CGFloat = CGFloat(addedTime / timeSpan)
        var percentageWidth:CGFloat = percentage * usableWidth
        
        if percentageWidth > usableWidth
        {
            percentageWidth = usableWidth
        }
        else if percentageWidth < 0
        {
            percentageWidth = 0
        }
        
        layoutTrackTop.constant = marginTop
        layoutTrackWidth.constant = usableWidth
        layoutThumbLeft.constant = percentageWidth
        layoutInsideTrackWidth.constant = percentageWidth
        
        DispatchQueue.main.async
        { [weak self] in
          
            self?.controller.viewPreview.viewPlayer.viewTimer.print()
        }
        
        super.layoutSubviews()
    }
    
    override func touchesBegan(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        thumbSelected()
        
        guard
            
            let touch:UITouch = touches.first,
            let view:UIView = touch.view
            
            else
        {
            return
        }
        
        if view !== viewThumb
        {
            updateLocation(touch:touch)
        }
    }
    
    override func touchesMoved(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        guard
            
            let touch:UITouch = touches.first
            
            else
        {
            return
        }
        
        updateLocation(touch:touch)
    }
    
    override func touchesCancelled(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        thumbNormal()
    }
    
    override func touchesEnded(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        thumbNormal()
    }
    
    //MARK: private
    
    private func updateLocation(touch:UITouch)
    {
        let touchLocation:CGPoint = touch.location(in:self)
        let touchX:CGFloat = touchLocation.x
        let usableX:CGFloat = touchX - thumbWidth_2
        var xPercent:CGFloat = usableX / usableWidth
        
        if xPercent > 1
        {
            xPercent = 1
        }
        else if xPercent < 0
        {
            xPercent = 0
        }
        
        controller.currentTime = round((TimeInterval(xPercent) * timeSpan) + kMinTime)
        setNeedsLayout()
    }
    
    private func thumbSelected()
    {
        viewThumb.image = #imageLiteral(resourceName: "assetCameraSliderSelected")
    }
    
    private func thumbNormal()
    {
        viewThumb.image = #imageLiteral(resourceName: "assetCameraSlider")
    }
}
