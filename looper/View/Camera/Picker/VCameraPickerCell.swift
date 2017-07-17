import UIKit

class VCameraPickerCell:UICollectionViewCell
{
    weak var indicator:UIImageView!
    weak var imageView:UIImageView!
    weak var baseBlur:UIView!
    private let kBorderWidth:CGFloat = 1
    private let kIndicatorSize:CGFloat = 50
    
    init(frame:CGRect, blurEffect:UIBlurEffect, blurAlpha:CGFloat)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        self.imageView = imageView
        
        let baseBlur:UIView = UIView()
        baseBlur.isUserInteractionEnabled = false
        baseBlur.translatesAutoresizingMaskIntoConstraints = false
        baseBlur.clipsToBounds = true
        baseBlur.alpha = blurAlpha
        self.baseBlur = baseBlur
        
        let blur:UIVisualEffectView = UIVisualEffectView(effect:blurEffect)
        blur.isUserInteractionEnabled = false
        blur.clipsToBounds = true
        blur.translatesAutoresizingMaskIntoConstraints = false
        
        let indicator:UIImageView = UIImageView()
        indicator.isUserInteractionEnabled = false
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.clipsToBounds = true
        indicator.contentMode = UIViewContentMode.center
        indicator.tintColor = UIColor.genericLight
        self.indicator = indicator
        
        baseBlur.addSubview(blur)
        addSubview(imageView)
        addSubview(baseBlur)
        addSubview(indicator)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:baseBlur)
        NSLayoutConstraint.equals(
            view:baseBlur,
            toView:self)
        NSLayoutConstraint.equals(
            view:imageView,
            toView:self)
        
        NSLayoutConstraint.size(
            view:indicator,
            constant:kIndicatorSize)
        NSLayoutConstraint.rightToRight(
            view:indicator,
            toView:self)
        NSLayoutConstraint.bottomToBottom(
            view:indicator,
            toView:self)
    }
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func config(model:MHomeUploadItem)
    {
        imageView.image = model.image
    }
}
