import UIKit

class VCameraCellItem:UICollectionViewCell
{
    private weak var model:MCameraRecordItem?
    private weak var imageView:UIImageView!
    private weak var indicator:UIView!
    private let kImageBottom:CGFloat = -7
    private let kIndicatorHeight:CGFloat = 3
    private let kAlphaActive:CGFloat = 1
    private let kAlphaNotActive:CGFloat = 0.2
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor(white:0, alpha:0.5).cgColor
        self.imageView = imageView
        
        let indicator:UIView = UIView()
        indicator.isUserInteractionEnabled = false
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.clipsToBounds = true
        self.indicator = indicator
        
        addSubview(indicator)
        addSubview(imageView)
        
        let layoutImageTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self)
        let layoutImageBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:imageView,
            toView:self,
            constant:kImageBottom)
        let layoutImageLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:imageView,
            toView:self)
        let layoutImageRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:imageView,
            toView:self)
        
        let layoutIndicatorBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:indicator,
            toView:self)
        let layoutIndicatorHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:indicator,
            constant:kIndicatorHeight)
        let layoutIndicatorLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:indicator,
            toView:self)
        let layoutIndicatorRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:indicator,
            toView:self)
        
        addConstraints([
            layoutImageTop,
            layoutImageBottom,
            layoutImageLeft,
            layoutImageRight,
            layoutIndicatorBottom,
            layoutIndicatorHeight,
            layoutIndicatorLeft,
            layoutIndicatorRight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func config(model:MCameraRecordItem)
    {
        self.model = model
        imageView.image = model.image
        update()
    }
    
    func update()
    {
        guard
        
            let model:MCameraRecordItem = self.model
        
        else
        {
            return
        }
        
        if model.active
        {
            imageView.alpha = kAlphaActive
            indicator.backgroundColor = UIColor.genericLight
        }
        else
        {
            imageView.alpha = kAlphaNotActive
            indicator.backgroundColor = UIColor(white:0.8, alpha:1)
        }
    }
}
