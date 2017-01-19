import UIKit

class VCameraFilterSelectorCellRecord:VCameraFilterSelectorCell
{
    private weak var imageView:UIImageView!
    private weak var layoutImageLeft:NSLayoutConstraint!
    private weak var framesIcon:UIImageView!
    private weak var label:UILabel!
    private let kCornerRadius:CGFloat = 8
    private let kImageTop:CGFloat = 250
    private let kImageSize:CGFloat = 134
    private let kBackgroundMargin:CGFloat = -3
    private let kFramesTop:CGFloat = 10
    private let kFramesLeft:CGFloat = 45
    private let kFramesSize:CGFloat = 20
    private let kLabelLeft:CGFloat = 5
    private let kLabelWidth:CGFloat = 100
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.backgroundColor = UIColor.black
        imageView.layer.cornerRadius = kCornerRadius
        self.imageView = imageView
        
        let background:UIView = UIView()
        background.isUserInteractionEnabled = false
        background.translatesAutoresizingMaskIntoConstraints = false
        background.clipsToBounds = true
        background.layer.cornerRadius = kCornerRadius - kBackgroundMargin
        background.backgroundColor = UIColor.genericLight
        
        let framesIcon:UIImageView = UIImageView()
        framesIcon.isUserInteractionEnabled = false
        framesIcon.clipsToBounds = true
        framesIcon.contentMode = UIViewContentMode.center
        framesIcon.translatesAutoresizingMaskIntoConstraints = false
        framesIcon.image = #imageLiteral(resourceName: "assetFilterFrames")
        
        let label:UILabel = UILabel()
        label.backgroundColor = UIColor.clear
        label.font = UIFont.regular(size:13)
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(white:0.2, alpha:1)
        self.label = label
        
        addSubview(background)
        addSubview(imageView)
        addSubview(label)
        addSubview(framesIcon)
        
        NSLayoutConstraint.equals(
            view:background,
            toView:imageView,
            margin:kBackgroundMargin)
        
        NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self,
            constant:kImageTop)
        layoutImageLeft = NSLayoutConstraint.leftToLeft(
            view:imageView,
            toView:self)
        NSLayoutConstraint.size(
            view:imageView,
            constant:kImageSize)
        
        NSLayoutConstraint.topToBottom(
            view:framesIcon,
            toView:imageView,
            constant:kFramesTop)
        NSLayoutConstraint.size(
            view:framesIcon,
            constant:kFramesSize)
        NSLayoutConstraint.leftToLeft(
            view:framesIcon,
            toView:imageView,
            constant:kFramesLeft)
        
        NSLayoutConstraint.equalsVertical(
            view:label,
            toView:framesIcon)
        NSLayoutConstraint.leftToRight(
            view:label,
            toView:framesIcon,
            constant:kLabelLeft)
        NSLayoutConstraint.width(
            view:label,
            constant:kLabelWidth)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remainImage:CGFloat = width - kImageSize
        let marginImage:CGFloat = remainImage / 2.0
        
        layoutImageLeft.constant = marginImage
        super.layoutSubviews()
    }
    
    override func config(model:MCameraFilterSelectorItem)
    {
        super.config(model:model)
        
        guard
        
            let model:MCameraFilterSelectorItemRecord = model as? MCameraFilterSelectorItemRecord
        
        else
        {
            return
        }
        
        let countFrames:Int = model.record.items.count
        let countString:String = "\(countFrames)"
        
        imageView.image = model.record.items.first?.image
        label.text = countString
    }
}
