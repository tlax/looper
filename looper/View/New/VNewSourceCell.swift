import UIKit

class VNewSourceCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private weak var labelTitle:UILabel!
    private weak var layoutCircleTop:NSLayoutConstraint!
    private weak var layoutCircleLeft:NSLayoutConstraint!
    private let kCircleSize:CGFloat = 60
    private let kBorderWidth:CGFloat = 1
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let circleView:UIView = UIView()
        circleView.isUserInteractionEnabled = false
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.clipsToBounds = true
        circleView.backgroundColor = UIColor.white
        circleView.layer.cornerRadius = kCircleSize / 2.0
        circleView.layer.borderWidth = kBorderWidth
        circleView.layer.borderColor = UIColor(white:0, alpha:0.2).cgColor
        
        addSubview(circleView)
        
        layoutCircleTop = NSLayoutConstraint.topToTop(
            view:circleView,
            toView:self)
        NSLayoutConstraint.size(
            view:circleView,
            constant:kCircleSize)
        layoutCircleLeft = NSLayoutConstraint.leftToLeft(
            view:circleView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.width
        let height:CGFloat = bounds.height
        let remainWidth:CGFloat = width - kCircleSize
        let remainHeight:CGFloat = height - kCircleSize
        let marginLeft:CGFloat = remainWidth / 2.0
        let marginTop:CGFloat = remainHeight / 2.0
        layoutCircleLeft.constant = marginLeft
        layoutCircleTop.constant = marginTop
        
        super.layoutSubviews()
    }
    
    //MARK: public
    
    func config(model:MSourceProtocol)
    {
        
    }
}
