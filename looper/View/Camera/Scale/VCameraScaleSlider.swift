import UIKit

class VCameraScaleSlider:UIView
{
    private weak var controller:CCameraScale!
    private weak var viewTrack:VCameraScaleSliderTrack!
    private weak var labelPercent:UILabel!
    private weak var thumb:UIImageView!
    private weak var layoutThumbBottom:NSLayoutConstraint!
    private var minThumbBottom:CGFloat
    private let numberFormatter:NumberFormatter
    private let attributesPercent:[String:AnyObject]
    private let attributesSize:[String:AnyObject]
    private let stringPercentSign:NSAttributedString
    private let stringTimesSign:NSAttributedString
    private let thumbSize_2:CGFloat
    private let kPercentSign:String = "% \n"
    private let kTimesSign:String = " x "
    private let kPercentMultiplier:CGFloat = 100
    private let kTrackLeft:CGFloat = 80
    private let kTrackWidth:CGFloat = 3
    private let kThumbSize:CGFloat = 42
    private let kLabelPercentHeight:CGFloat = 38
    private let kLabelsWidth:CGFloat = 240
    private let kLabelsLeft:CGFloat = 5
    private let kMaxDecimals:Int = 0
    private let kMinIntegers:Int = 1
    
    init(controller:CCameraScale)
    {
        minThumbBottom = 0
        thumbSize_2 = kThumbSize / 2.0
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.maximumFractionDigits = kMaxDecimals
        numberFormatter.minimumIntegerDigits = kMinIntegers
        
        let attributesSigns:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:14),
            NSForegroundColorAttributeName:UIColor.genericDark]
        attributesPercent = [
            NSFontAttributeName:UIFont.bold(size:34),
            NSForegroundColorAttributeName:UIColor.genericLight]
        attributesSize = [
            NSFontAttributeName:UIFont.bold(size:25),
            NSForegroundColorAttributeName:UIColor.genericAlternative]
        
        stringPercentSign = NSAttributedString(
            string:kPercentSign,
            attributes:attributesSigns)
        stringTimesSign = NSAttributedString(
            string:kTimesSign,
            attributes:attributesSigns)
        
        super.init(frame:CGRect.zero)
        clipsToBounds = false
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let trackWidth_2:CGFloat = kTrackWidth / 2.0
        let thumbLeft:CGFloat = kTrackLeft - thumbSize_2 + trackWidth_2
        
        let viewTrack:VCameraScaleSliderTrack = VCameraScaleSliderTrack()
        viewTrack.layer.cornerRadius = kTrackWidth / 2.0
        self.viewTrack = viewTrack
        
        let thumb:UIImageView = UIImageView()
        thumb.isUserInteractionEnabled = false
        thumb.translatesAutoresizingMaskIntoConstraints = false
        thumb.clipsToBounds = true
        thumb.contentMode = UIViewContentMode.center
        thumb.image = #imageLiteral(resourceName: "assetCameraScaleThumb")
        self.thumb = thumb
        
        let labelPercent:UILabel = UILabel()
        labelPercent.translatesAutoresizingMaskIntoConstraints = false
        labelPercent.backgroundColor = UIColor.clear
        labelPercent.isUserInteractionEnabled = false
        labelPercent.font = UIFont.bold(size:34)
        labelPercent.textColor = UIColor.genericLight
        self.labelPercent = labelPercent
        
        addSubview(viewTrack)
        addSubview(thumb)
        addSubview(labelPercent)
        
        NSLayoutConstraint.topToTop(
            view:viewTrack,
            toView:self)
        NSLayoutConstraint.bottomToBottom(
            view:viewTrack,
            toView:self,
            constant:-thumbSize_2)
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
        
        NSLayoutConstraint.topToTop(
            view:viewTrack.selectedView,
            toView:thumb,
            constant:thumbSize_2)
        NSLayoutConstraint.bottomToBottom(
            view:viewTrack.selectedView,
            toView:self,
            constant:-thumbSize_2)
        
        NSLayoutConstraint.topToTop(
            view:labelPercent,
            toView:thumb)
        NSLayoutConstraint.height(
            view:labelPercent,
            constant:kLabelPercentHeight)
        NSLayoutConstraint.leftToRight(
            view:labelPercent,
            toView:thumb,
            constant:kLabelsLeft)
        NSLayoutConstraint.width(
            view:labelPercent,
            constant:kLabelsWidth)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let height:CGFloat = bounds.maxY
        minThumbBottom = -(height - thumbSize_2)
        
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func print(percent:CGFloat)
    {
        let percentAmount:CGFloat = percent * kPercentMultiplier
        let percentNumber:NSNumber = percentAmount as NSNumber
        
        guard
            
            let percentString:String = numberFormatter.string(from:percentNumber)
        
        else
        {
            return
        }
        
        let attributeStringPercent:NSAttributedString = NSAttributedString(
            string:percentString,
            attributes:attributesPercent)
        
        let mutableString:NSMutableAttributedString = NSMutableAttributedString()
        mutableString.append(attributeStringPercent)
        mutableString.append(stringPercentSign)
        
        labelPercent.attributedText = mutableString
    }
    
    //MARK: public
    
    func sliderSelected(percent:CGFloat)
    {
        let thumbBottom:CGFloat = percent * minThumbBottom
        layoutThumbBottom.constant = thumbBottom
        print(percent:percent)
    }
}
