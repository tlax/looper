import UIKit

class VCameraFilterSelectorCellRecord:VCameraFilterSelectorCell
{
    private weak var imageView:UIImageView!
    private weak var background:UIView!
    private weak var layoutImageLeft:NSLayoutConstraint!
    private let kCornerRadius:CGFloat = 8
    private let kImageTop:CGFloat = 250
    private let kImageSize:CGFloat = 134
    private let kBackgroundMargin:CGFloat = -3
    
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
        background.layer.cornerRadius = kCornerRadius + kBackgroundMargin
        self.background = background
        
        addSubview(background)
        addSubview(imageView)
        
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
        
        imageView.image = model.record.items.first?.image
    }
}
