import UIKit

class VCameraFilterBlenderOverlayBase:UIView
{
    private let kImageMargin:CGFloat = 2
    private let kImageAlpha:CGFloat = 0.7
    
    init(model:MCameraFilterSelectorItem)
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        
        if let modelRecord:MCameraFilterSelectorItemRecord = model as? MCameraFilterSelectorItemRecord
        {
            backgroundColor = UIColor.black
            
            let imageView:UIImageView = UIImageView()
            imageView.isUserInteractionEnabled = false
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = UIViewContentMode.scaleAspectFill
            imageView.clipsToBounds = true
            imageView.alpha = kImageAlpha
            imageView.image = modelRecord.record.items.first?.image
            
            addSubview(imageView)
            
            NSLayoutConstraint.equals(
                view:imageView,
                toView:self,
                margin:kImageMargin)
        }
        else if let modelColor:MCameraFilterSelectorItemColor = model as? MCameraFilterSelectorItemColor
        {
            backgroundColor = modelColor.color
        }
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
