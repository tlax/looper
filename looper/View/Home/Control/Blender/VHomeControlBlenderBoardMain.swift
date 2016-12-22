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
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func dropping(piece:VHomeControlBlenderPiecesItem)
    {
        let pieceRect:CGRect = piece.frame
        
        if frame.intersects(pieceRect)
        {
            print("yes")
        }
        else
        {
            print("no")
        }
    }
}
