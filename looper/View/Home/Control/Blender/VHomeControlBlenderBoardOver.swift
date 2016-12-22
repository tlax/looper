import UIKit

class VHomeControlBlenderBoardOver:UIView
{
    weak var imageView:UIImageView!
    weak var layoutTop:NSLayoutConstraint!
    weak var layoutLeft:NSLayoutConstraint!
    weak var layoutWidth:NSLayoutConstraint!
    weak var layoutHeight:NSLayoutConstraint!
    private let kBorderWidth:CGFloat = 2
    private let kCornerRadius:CGFloat = 8
    private let kImageAlpha:CGFloat = 0.3
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor(white:1, alpha:0.1)
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        layer.borderColor = UIColor(white:1, alpha:0.3).cgColor
        layer.borderWidth = kBorderWidth
        layer.cornerRadius = kCornerRadius
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.alpha = kImageAlpha
        self.imageView = imageView
        
        addSubview(imageView)
        
        let layoutImageTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self)
        let layoutImageBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:imageView,
            toView:self)
        let layoutImageLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:imageView,
            toView:self)
        let layoutImageRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:imageView,
            toView:self)
        
        addConstraints([
            layoutImageTop,
            layoutImageBottom,
            layoutImageLeft,
            layoutImageRight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func dropping(piece:VHomeControlBlenderPiecesItem)
    {
        let pieceRect:CGRect = piece.frame
        let intersects:Bool = frame.intersects(pieceRect)
        
        if intersects
        {
            let posX:CGFloat = frame.minX
            let posY:CGFloat = frame.minY
            let size:CGFloat = bounds.maxX
            let pieceX:CGFloat = pieceRect.minX
            let pieceY:CGFloat = pieceRect.minY
            let pieceSize:CGFloat = pieceRect.size.width
            let pieceSize_2:CGFloat = pieceSize / 2.0
            let centerX:CGFloat = piece
            
            piece.placed()
        }
    }
}
