import UIKit

class VCameraFilterBlenderOverlayBase:UIView
{
    private weak var imageView:UIImageView!
    private let kImageMargin:CGFloat = 2
    private let kImageAlpha:CGFloat = 0.4
    
    init(model:MCameraRecord?)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        backgroundColor = UIColor.black
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = model?.items.first?.image
        imageView.alpha = kImageAlpha
        self.imageView = imageView
        
        addSubview(imageView)
        
        let constraintsImage:[NSLayoutConstraint] = NSLayoutConstraint.equalsHorizontal(
            view:imageView,
            toView:self,
            margin:kImageMargin)
        
        addConstraints(constraintsImage)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func validatePiece(viewPiece:VCameraFilterBlenderOverlayPiece)
    {
        let pieceFrame:CGRect = viewPiece.frame
        
        if frame.intersects(pieceFrame)
        {
            viewPiece.insideBase()
        }
        else
        {
            viewPiece.outsideBase()
        }
    }
}
