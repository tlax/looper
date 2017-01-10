import UIKit

class VCameraFilterBlenderOverlayPiece:UIView
{
    weak var model:MCameraRecord!
    private weak var imageView:UIImageView!
    private let kCornerRadius:CGFloat = 10
    
    init(model:MCameraRecord)
    {
        super.init(frame:CGRect.zero)
        isUserInteractionEnabled = false
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = kCornerRadius
        self.model = model
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = model.items.first?.image
        self.imageView = imageView
        
        addSubview(imageView)
        
        let constraintsImage:[NSLayoutConstraint] = NSLayoutConstraint.equals(
            view:imageView,
            toView:self)
        
        addConstraints(constraintsImage)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
