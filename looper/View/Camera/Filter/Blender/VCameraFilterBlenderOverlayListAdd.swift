import UIKit

class VCameraFilterBlenderOverlayListAdd:UIButton
{
    weak var layoutLeft:NSLayoutConstraint!
    private weak var image:UIImageView!
    private let kAnimationImagesDuration:TimeInterval = 0.16
    private let kAnimationDuration:TimeInterval = 0.8
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        
        let animatingImages:[UIImage] = [
        #imageLiteral(resourceName: "assetCameraFilterBlenderAdd1"),
        #imageLiteral(resourceName: "assetCameraFilterBlenderAdd2"),
        #imageLiteral(resourceName: "assetCameraFilterBlenderAdd3"),
        #imageLiteral(resourceName: "assetCameraFilterBlenderAdd4"),
        #imageLiteral(resourceName: "assetCameraFilterBlenderAdd5"),
        #imageLiteral(resourceName: "assetCameraFilterBlenderAdd0")]
        
        let image:UIImageView = UIImageView()
        image.isUserInteractionEnabled = false
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = UIViewContentMode.center
        image.image = #imageLiteral(resourceName: "assetCameraFilterBlenderAdd0")
        image.animationImages = animatingImages
        image.animationDuration = kAnimationImagesDuration
        self.image = image
        
        addSubview(image)
        
        let constraintsImage:[NSLayoutConstraint] = NSLayoutConstraint.equals(
            view:image,
            toView:self)
        
        addConstraints(constraintsImage)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    deinit
    {
        image.stopAnimating()
    }
    
    //MARK: public
    
    func animateHide()
    {
        guard
            
            let width:CGFloat = superview?.bounds.maxX
        
        else
        {
            return
        }
        
        image.startAnimating()
        layoutLeft.constant = width
        UIView.animate(
            withDuration:kAnimationDuration,
            animations:
        { [weak self] in
            
            self?.superview?.layoutIfNeeded()
            
        })
        { [weak self] (done:Bool) in
        
            self?.image.stopAnimating()
        }
    }
    
    func animateShow()
    {
        guard
            
            let width:CGFloat = superview?.bounds.maxX
            
        else
        {
            return
        }
        
        let selfWidth:CGFloat = bounds.maxX
        let remainLeft:CGFloat = width - selfWidth
        let marginLeft:CGFloat = remainLeft / 2.0
        
        image.startAnimating()
        layoutLeft.constant = marginLeft
        UIView.animate(
            withDuration:kAnimationDuration,
            animations:
        { [weak self] in
            
            self?.superview?.layoutIfNeeded()
            
        })
        { [weak self] (done:Bool) in
            
            self?.image.stopAnimating()
        }
    }
}
