import UIKit

class VHomeControlBlenderBoardMain:UIView
{
    weak var layoutTop:NSLayoutConstraint!
    weak var layoutLeft:NSLayoutConstraint!
    weak var layoutWidth:NSLayoutConstraint!
    weak var layoutHeight:NSLayoutConstraint!
    private let kBorderWidth:CGFloat = 2
    private let kCornerRadius:CGFloat = 10
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor(white:1, alpha:0.1)
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = kCornerRadius
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
