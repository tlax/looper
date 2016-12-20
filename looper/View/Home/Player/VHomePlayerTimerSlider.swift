import UIKit

class VHomePlayerTimerSlider:UIView
{
    var currentTime:TimeInterval
    private weak var controller:CHome!
    private weak var viewThumb:UIImageView!
    private weak var layoutTrackTop:NSLayoutConstraint!
    private weak var layoutThumbLeft:NSLayoutConstraint!
    private let kMinTime:TimeInterval = 0.5
    private let kMaxTime:TimeInterval = 10
    private let kStartTime:TimeInterval = 2
    private let kTrackHeight:CGFloat = 4
    private let kThumbWidth:CGFloat = 30
    
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
        
        let viewThumb:UIImageView = UIImageView()
        viewThumb.isUserInteractionEnabled = false
        viewThumb.translatesAutoresizingMaskIntoConstraints = false
        viewThumb.clipsToBounds = true
        viewThumb.contentMode = UIViewContentMode.center
        self.viewThumb = viewThumb
        
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
            toView:self)
        let layoutTrackRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:track,
            toView:self)
        
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
        
        addConstraints([
            layoutTrackTop,
            layoutTrackHeight,
            layoutTrackLeft,
            layoutTrackRight,
            layoutThumbTop,
            layoutThumbBottom,
            layoutThumbWidth,
            layoutThumbLeft])
        
        thumbNormal()
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
