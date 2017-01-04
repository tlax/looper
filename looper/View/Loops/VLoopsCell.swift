import UIKit

class VLoopsCell:UICollectionViewCell
{
    private weak var model:MLoopsItem?
    private weak var imageView:UIImageView!
    private let kBackgroundMargin:CGFloat = 2
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let height:CGFloat = frame.size.height
        
        let background:UIView = UIView()
        background.clipsToBounds = true
        background.translatesAutoresizingMaskIntoConstraints = false
        background.isUserInteractionEnabled = false
        background.backgroundColor = UIColor.genericBackground
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView = imageView
        
        addSubview(background)
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
        let layoutImageWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:imageView,
            constant:height)
        
        let layoutBackgroundTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:background,
            toView:self)
        let layoutBackgroundBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:background,
            toView:self)
        let layoutBackgroundLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:background,
            toView:self)
        let layoutBackgroundWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:background,
            constant:height + kBackgroundMargin)
        
        addConstraints([
            layoutImageTop,
            layoutImageBottom,
            layoutImageLeft,
            layoutImageWidth,
            layoutBackgroundTop,
            layoutBackgroundBottom,
            layoutBackgroundLeft,
            layoutBackgroundWidth])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func config(model:MLoopsItem)
    {
        self.model = model
        imageView.image = model.images.first
    }
}
