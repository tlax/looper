import UIKit

class VCameraHeaderButton:UIButton
{
    private let kAlphaNotHover:CGFloat = 1
    private let kAlphaHover:CGFloat = 0.2
    
    convenience init(image:UIImage)
    {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        setImage(
            image,
            for:UIControlState.normal)
        setImage(
            image,
            for:UIControlState.highlighted)
        imageView!.contentMode = UIViewContentMode.center
        imageView!.clipsToBounds = true
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
        isUserInteractionEnabled = false
    }
    
    func notActive()
    {
        alpha = kAlphaHover
        isUserInteractionEnabled = true
    }
}
