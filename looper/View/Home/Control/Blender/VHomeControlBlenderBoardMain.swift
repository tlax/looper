import UIKit

class VHomeControlBlenderBoardMain:UIView
{
    weak var piece:VHomeControlBlenderPiecesItem?
    weak var layoutTop:NSLayoutConstraint!
    weak var layoutLeft:NSLayoutConstraint!
    weak var layoutWidth:NSLayoutConstraint!
    weak var layoutHeight:NSLayoutConstraint!
    private let kBorderWidth:CGFloat = 2
    private let kCornerRadius:CGFloat = 8
    private let kAnimationDuration:TimeInterval = 0.3
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor(white:1, alpha:0.15)
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        layer.borderColor = UIColor(white:1, alpha:0.3).cgColor
        layer.borderWidth = kBorderWidth
        layer.cornerRadius = kCornerRadius
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
            let pieceSize:CGFloat = pieceRect.size.width
            let deltaSize:CGFloat = size - pieceSize
            let margin:CGFloat = deltaSize / 2.0
            piece.layoutLeft.constant = posX + margin
            piece.layoutTop.constant = posY + margin
            
            UIView.animate(
                withDuration:kAnimationDuration)
            { [weak piece] in
                
                piece?.superview?.layoutIfNeeded()
            }
            
            piece.placed()
            
            if piece !== self.piece
            {
                self.piece?.restartPlace()
                self.piece = piece
            }
        }
        else
        {
            if piece === self.piece
            {
                self.piece = nil
            }
        }
    }
}
