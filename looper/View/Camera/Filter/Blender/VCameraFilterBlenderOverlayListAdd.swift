import UIKit

class VCameraFilterBlenderOverlayListAdd:UIButton
{
    private weak var image:UIImageView!
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        
        let image:UIImageView = UIImageView()
        image.isUserInteractionEnabled = false
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = UIViewContentMode.center
        image.image = #imageLiteral(resourceName: "assetCameraFilterBlenderAdd")
        self.image = image
        
        addSubview(image)
        
        let constraintsImage:[NSLayoutConstraint] = NSLayoutConstraint.equals(
            view:image,
            parent:self)
        
        addConstraints(constraintsImage)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
