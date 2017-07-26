import UIKit

class VEditDurationCell:UICollectionViewCell
{
    private weak var label:UILabel!
    private weak var viewCircle:UIView!
    private weak var layoutCircleLeft:NSLayoutConstraint!
    private weak var layoutCircleTop:NSLayoutConstraint!
    private let kCircleSize:CGFloat = 38
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let viewCircle:UIView = UIView()
        viewCircle.isUserInteractionEnabled = false
        viewCircle.translatesAutoresizingMaskIntoConstraints = false
        viewCircle.backgroundColor = UIColor(red:1, green:0.2, blue:0, alpha:1)
        viewCircle.clipsToBounds = true
        viewCircle.layer.cornerRadius = kCircleSize / 2.0
        self.viewCircle = viewCircle
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.medium(size:16)
        self.label = label
        
        addSubview(viewCircle)
        addSubview(label)
        
        NSLayoutConstraint.equals(
            view:label,
            toView:self)
        
        layoutCircleTop = NSLayoutConstraint.topToTop(
            view:viewCircle,
            toView:self)
        layoutCircleLeft = NSLayoutConstraint.leftToLeft(
            view:viewCircle,
            toView:self)
        NSLayoutConstraint.size(
            view:viewCircle,
            constant:kCircleSize)
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
    
    override var isSelected:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    override var isHighlighted:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    //MARK: private
    
    private func hover()
    {
        if isSelected || isHighlighted
        {
            viewCircle.isHidden = false
            label.textColor = UIColor.white
        }
        else
        {
            viewCircle.isHidden = true
            label.textColor = UIColor.colourBackgroundDark.withAlphaComponent(0.5)
        }
    }
    
    //MARK: public
    
    func config(model:MEditDurationItem)
    {
        label.text = "\(model.value)"
        hover()
    }
}
