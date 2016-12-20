import UIKit

class VHomeDisplay:UIView
{
    private weak var controller:CHome!
    private weak var imageView:UIImageView!
    private let kImageMargin:CGFloat = 10
    
    convenience init(controller:CHome)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        self.controller = controller
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.clipsToBounds = true
        self.imageView = imageView
        
        addSubview(imageView)
        
        let layoutImageTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self,
            constant:kImageMargin)
        let layoutImageBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:imageView,
            toView:self,
            constant:-kImageMargin)
        let layoutImageLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:imageView,
            toView:self,
            constant:kImageMargin)
        let layoutImageRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:imageView,
            toView:self,
            constant:-kImageMargin)
        
        addConstraints([
            layoutImageTop,
            layoutImageBottom,
            layoutImageLeft,
            layoutImageRight])
    }
    
    //MARK: public
    
    func displayFrame(image:UIImage)
    {
        imageView.animationImages = nil
        imageView.stopAnimating()
        imageView.image = image
    }
    
    func animateImages(images:[UIImage])
    {
        imageView.image = nil
        imageView.animationImages = images
        imageView.startAnimating()
    }
    
    func stopAnimation()
    {
        imageView.stopAnimating()
        imageView.image = imageView.animationImages?.first
        imageView.animationImages nil
    }
}
