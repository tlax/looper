import UIKit

class VCameraActiveButton:UIButton
{
    private let kAlphaNotHover:CGFloat = 1
    private let kAlphaHover:CGFloat = 0.25
    private let image:UIImage
    
    init(image:UIImage)
    {
        self.image = image
        super.init(frame:CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        setImage(
            image.withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.highlighted)
        imageView!.contentMode = UIViewContentMode.center
        imageView!.clipsToBounds = true
        imageView!.tintColor = UIColor(white:0.9, alpha:1)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override var isSelected:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    override var isHighlighted:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    //MARK: private
    
    private func hover()
    {
        if isSelected || isHighlighted
        {
            alpha = kAlphaHover
        }
        else
        {
            alpha = kAlphaNotHover
        }
    }
    
    //MARK: public
    
    func active()
    {
        alpha = kAlphaNotHover
        isUserInteractionEnabled = true
        
        setImage(
            image.withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
    }
    
    func notActive()
    {
        alpha = kAlphaNotHover
        isUserInteractionEnabled = false
        
        setImage(
            image.withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.normal)
    }
}
