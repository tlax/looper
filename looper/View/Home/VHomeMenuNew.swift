import UIKit

class VHomeMenuNew:View<VHome, MHome, CHome>
{
    private let kAlphaSelected:CGFloat = 0.2
    private let kAlphaNotSelected:CGFloat = 1
    private let kAnimationDuration:TimeInterval = 15
    
    private class func factoryImages() -> [UIImage]
    {
        let images:[UIImage] = [
            #imageLiteral(resourceName: "assetGenericNew00"),
            #imageLiteral(resourceName: "assetGenericNew01"),
            #imageLiteral(resourceName: "assetGenericNew02"),
            #imageLiteral(resourceName: "assetGenericNew03"),
            #imageLiteral(resourceName: "assetGenericNew04"),
            #imageLiteral(resourceName: "assetGenericNew05"),
            #imageLiteral(resourceName: "assetGenericNew06"),
            #imageLiteral(resourceName: "assetGenericNew07"),
            #imageLiteral(resourceName: "assetGenericNew08"),
            #imageLiteral(resourceName: "assetGenericNew09"),
            #imageLiteral(resourceName: "assetGenericNew10"),
            #imageLiteral(resourceName: "assetGenericNew11"),
            #imageLiteral(resourceName: "assetGenericNew00"),
            #imageLiteral(resourceName: "assetGenericNew00"),
            #imageLiteral(resourceName: "assetGenericNew00"),
            #imageLiteral(resourceName: "assetGenericNew00"),
            #imageLiteral(resourceName: "assetGenericNew00")]
        
        return images
    }
    
    required init(controller:CHome)
    {
        super.init(controller:controller)
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.animationImages = VHomeMenuNew.factoryImages()
        imageView.animationDuration = kAnimationDuration
        imageView.startAnimating()
        
        let buttonNew:UIButton = UIButton()
        buttonNew.translatesAutoresizingMaskIntoConstraints = false
        buttonNew.imageView!.clipsToBounds = true
        buttonNew.imageView!.contentMode = UIViewContentMode.center
        buttonNew.addTarget(
            self,
            action:#selector(actionHover(sender:)),
            for:UIControlEvents.touchDown)
        buttonNew.addTarget(
            self,
            action:#selector(actionUnHover(sender:)),
            for:UIControlEvents.touchUpOutside)
        buttonNew.addTarget(
            self,
            action:#selector(actionNew(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(imageView)
        addSubview(buttonNew)
        
        NSLayoutConstraint.equals(
            view:imageView,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:buttonNew,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionHover(sender button:UIButton)
    {
        alpha = kAlphaSelected
    }
    
    func actionUnHover(sender button:UIButton)
    {
        alpha = kAlphaNotSelected
    }
    
    func actionNew(sender button:UIButton)
    {
        controller.openCreate()
        alpha = kAlphaNotSelected
    }
}
