import UIKit

class VCameraScaleSlider:UIView
{
    private weak var viewTrack:VCameraScaleSliderTrack!
    private weak var labelPercent:UILabel!
    private weak var labelSize:UILabel!
    private weak var thumb:UIImageView!
    private weak var layoutThumbBottom:NSLayoutConstraint!
    private var minThumbBottom:CGFloat
    private let kTrackLeft:CGFloat = 80
    private let kTrackWidth:CGFloat = 3
    private let kTrackVerticalMargin:CGFloat = 1
    private let kThumbSize:CGFloat = 40
    
    init()
    {
        minThumbBottom = 0
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        
        let thumbSize_2:CGFloat = kThumbSize / 2.0
        let thumbLeft:CGFloat = kTrackLeft - thumbSize_2
        
        let viewTrack:VCameraScaleSliderTrack = VCameraScaleSliderTrack()
        self.viewTrack = viewTrack
        
        let thumb:UIImageView = UIImageView()
        thumb.isUserInteractionEnabled = false
        thumb.translatesAutoresizingMaskIntoConstraints = false
        thumb.clipsToBounds = true
        thumb.contentMode = UIViewContentMode.center
        thumb.image = #imageLiteral(resourceName: "assetCameraScaleThumb")
        thumb.alpha = 0.2
        self.thumb = thumb
        
        addSubview(viewTrack)
        addSubview(thumb)
        
        NSLayoutConstraint.equalsVertical(
            view:viewTrack,
            toView:self,
            margin:kTrackVerticalMargin)
        NSLayoutConstraint.leftToLeft(
            view:viewTrack,
            toView:self,
            constant:kTrackLeft)
        NSLayoutConstraint.width(
            view:viewTrack,
            constant:kTrackWidth)
        
        layoutThumbBottom = NSLayoutConstraint.bottomToBottom(
            view:thumb,
            toView:self)
        NSLayoutConstraint.size(
            view:thumb,
            constant:kThumbSize)
        NSLayoutConstraint.leftToLeft(
            view:thumb,
            toView:self,
            constant:thumbLeft)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let height:CGFloat = bounds.maxY
        minThumbBottom = -(height - kThumbSize)
        
        super.layoutSubviews()
    }
    
    //MARK: public
    
    func sliderSelected(percent:CGFloat)
    {
        let thumbBottom:CGFloat = percent * minThumbBottom
        layoutThumbBottom.constant = thumbBottom
        viewTrack.trackSelected(percent:percent)
    }
}
