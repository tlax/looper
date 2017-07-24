import UIKit

class VHomeMenuNew:View<VHome, MHome, CHome>
{
    private let kAlphaSelected:CGFloat = 0.2
    private let kAlphaNotSelected:CGFloat = 1
    
    required init(controller:CHome)
    {
        super.init(controller:controller)
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "assetGenericNew")
        
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
        controller.openNew()
        alpha = kAlphaNotSelected
    }
}
