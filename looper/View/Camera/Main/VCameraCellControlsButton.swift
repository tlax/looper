import UIKit

class VCameraCellControlsButton:UIButton
{
    init(image:UIImage, backgroundColor:UIColor)
    {
        super.init(frame:CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        setImage(
            image.withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        setImage(
            image.withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        imageView!.tintColor = UIColor(white:0, alpha:0.1)
        imageView!.clipsToBounds = true
        imageView!.contentMode = UIViewContentMode.center
        self.backgroundColor = backgroundColor
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
