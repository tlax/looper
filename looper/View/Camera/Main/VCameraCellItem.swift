import UIKit

class VCameraCellItem:UICollectionViewCell
{
    private weak var model:MCameraRecordItem?
    private weak var imageView:UIImageView!
    private let kAlphaActive:CGFloat = 1
    private let kAlphaNotActive:CGFloat = 0.15
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView = imageView
        
        addSubview(imageView)
        
        let layoutImageTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self)
        let layoutImageBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:imageView,
            toView:self)
        let layoutImageLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:imageView,
            toView:self)
        let layoutImageRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:imageView,
            toView:self)
        
        addConstraints([
            layoutImageTop,
            layoutImageBottom,
            layoutImageLeft,
            layoutImageRight])
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
            backgroundColor = UIColor.genericLight
        }
        else
        {
            imageView.alpha = kAlphaNotActive
            backgroundColor = UIColor.clear
        }
    }
}
