import UIKit

class VCameraCropImageThumb:UIImageView
{
    weak var layoutTop:NSLayoutConstraint!
    weak var layoutLeft:NSLayoutConstraint!
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = UIViewContentMode.center
        isUserInteractionEnabled = false
        
        state(selected:false)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func initConstraints(size:CGFloat)
    {
        guard
            
            let superview:UIView = self.superview
        
        else
        {
            return
        }
        
        layoutTop = NSLayoutConstraint.topToTop(
            view:self,
            toView:superview)
        layoutLeft = NSLayoutConstraint.leftToLeft(
            view:self,
            toView:superview)
        NSLayoutConstraint.size(
            view:self,
            constant:size)
    }
    
    func state(selected:Bool)
    {
        if selected
        {
            image = #imageLiteral(resourceName: "assetCameraScaleThumb")
        }
        else
        {
            image = #imageLiteral(resourceName: "assetCameraScaleThumb")
        }
    }
}
