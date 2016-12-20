import UIKit

class VHomePlayerTimerSlider:UIView
{
    var currentTime:TimeInterval
    private weak var controller:CHome!
    private weak var layoutTrackTop:NSLayoutConstraint!
    private let kMinTime:TimeInterval = 0.5
    private let kMaxTime:TimeInterval = 10
    private let kStartTime:TimeInterval = 2
    private let kTrackHeight:CGFloat = 4
    
    init(controller:CHome)
    {
        currentTime = kStartTime
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let track:UIView = UIView()
        track.isUserInteractionEnabled = false
        track.translatesAutoresizingMaskIntoConstraints = false
        track.clipsToBounds = true
        track.backgroundColor = UIColor.black
        track.layer.cornerRadius = kTrackHeight / 2.0
        
        addSubview(track)
        
        layoutTrackTop = NSLayoutConstraint.topToTop(
            view:track,
            toView:self)
        let layoutTrackHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:track,
            constant:kTrackHeight)
        let layoutTrackLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:track,
            toView:self)
        let layoutTrackRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:track,
            toView:self)
        
        addConstraints([
            layoutTrackTop,
            layoutTrackHeight,
            layoutTrackLeft,
            layoutTrackRight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let height:CGFloat = bounds.maxY
        let remain:CGFloat = height - kTrackHeight
        let margin:CGFloat = remain / 2.0
        layoutTrackTop.constant = margin
        
        super.layoutSubviews()
    }
}
