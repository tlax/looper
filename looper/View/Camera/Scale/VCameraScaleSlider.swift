import UIKit

class VCameraScaleSlider:UIView
{
    private weak var viewTrack:VCameraScaleSliderTrack!
    private weak var labelPercent:UILabel!
    private weak var labelSize:UILabel!
    private weak var thumb:UIImageView!
    private let kTrackLeft:CGFloat = 50
    private let kTrackWidth:CGFloat = 5
    private let kTrackVerticalMargin:CGFloat = 1
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        
        let viewTrack:VCameraScaleSliderTrack = VCameraScaleSliderTrack()
        self.viewTrack = viewTrack
        
        addSubview(viewTrack)
        
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
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
