import UIKit

class VHomePlayerTimerSlider:UIView
{
    var currentTime:TimeInterval
    private weak var controller:CHome!
    private weak var viewThumb:UIImageView!
    private weak var layoutTrackTop:NSLayoutConstraint!
    private weak var layoutTrackWidth:NSLayoutConstraint!
    private weak var layoutThumbLeft:NSLayoutConstraint!
    private weak var layoutInsideTrackWidth:NSLayoutConstraint!
    private let timeSpan:TimeInterval
    private let thumbWidth_2:CGFloat
    private let kMinTime:TimeInterval = 0.5
    private let kMaxTime:TimeInterval = 10
    private let kStartTime:TimeInterval = 2
    private let kTrackHeight:CGFloat = 4
    private let kThumbWidth:CGFloat = 30
    
    init(controller:CHome)
    {
        currentTime = kStartTime
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
        track.backgroundColor = UIColor.black
        track.layer.cornerRadius = kTrackHeight / 2.0
        
        let insideTrack:UIView = UIView()
        insideTrack.isUserInteractionEnabled = false
        insideTrack.clipsToBounds = true
        insideTrack.backgroundColor = UIColor.genericLight
        insideTrack.translatesAutoresizingMaskIntoConstraints = false
        
        let viewThumb:UIImageView = UIImageView()
        viewThumb.isUserInteractionEnabled = false
        viewThumb.translatesAutoresizingMaskIntoConstraints = false
        viewThumb.clipsToBounds = true
        viewThumb.contentMode = UIViewContentMode.center
        self.viewThumb = viewThumb
        
        track.addSubview(insideTrack)
        addSubview(track)
        addSubview(viewThumb)
        
        layoutTrackTop = NSLayoutConstraint.topToTop(
            view:track,
            toView:self)
        let layoutTrackHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:track,
            constant:kTrackHeight)
        let layoutTrackLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:track,
            toView:self,
            constant:thumbWidth_2)
        layoutTrackWidth = NSLayoutConstraint.width(
            view:track)
        
        let layoutThumbTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:viewThumb,
            toView:self)
        let layoutThumbBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:viewThumb,
            toView:self)
        let layoutThumbWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:viewThumb,
            constant:kThumbWidth)
        layoutThumbLeft = NSLayoutConstraint.leftToLeft(
            view:viewThumb,
            toView:self)
        
        let layoutInsideTrackTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:insideTrack,
            toView:track)
        let layoutInsideTrackBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:insideTrack,
            toView:track)
        let layoutInsideTrackLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:insideTrack,
            toView:track)
        layoutInsideTrackWidth = NSLayoutConstraint.width(
            view:insideTrack)
        
        addConstraints([
            layoutTrackTop,
            layoutTrackHeight,
            layoutTrackLeft,
            layoutTrackWidth,
            layoutThumbTop,
            layoutThumbBottom,
            layoutThumbWidth,
            layoutThumbLeft,
            layoutInsideTrackTop,
            layoutInsideTrackBottom,
            layoutInsideTrackLeft,
            layoutInsideTrackWidth])
        
        thumbNormal()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let height:CGFloat = bounds.maxY
        let remainHeight:CGFloat = height - kTrackHeight
        let remainWidth:CGFloat = width - kThumbWidth
        let marginTop:CGFloat = remainHeight / 2.0
        
        let addedTime:TimeInterval = currentTime - kMinTime
        let percentage:CGFloat = CGFloat(addedTime / timeSpan)
        var percentageWidth:CGFloat = percentage * remainWidth
        
        if percentageWidth > remainWidth
        {
            percentageWidth = remainWidth
        }
        else if percentageWidth < 0
        {
            percentageWidth = 0
        }
        
        layoutTrackTop.constant = marginTop
        layoutTrackWidth.constant = remainWidth
        layoutThumbLeft.constant = percentageWidth
        layoutInsideTrackWidth.constant = percentageWidth
        
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func thumbSelected()
    {
        viewThumb.image = #imageLiteral(resourceName: "assetHomePlayerSliderSelected")
    }
    
    private func thumbNormal()
    {
        viewThumb.image = #imageLiteral(resourceName: "assetHomePlayerSlider")
    }
}
