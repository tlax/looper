import UIKit

class VSourceVideoBarInfoCell:View<VSourceVideo, MSourceVideo, CSourceVideo>
{
    private weak var labelTitle:UILabel!
    private weak var labelValue:UILabel!
    private weak var layoutTitleRight:NSLayoutConstraint!
    private let kTitleWidth:CGFloat = 200
    private let kValueWidth:CGFloat = 200
    private let kValueLeft:CGFloat = 10
    
    required init(controller:CSourceVideo)
    {
        super.init(controller:controller)
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.textAlignment = NSTextAlignment.right
        labelTitle.textColor = UIColor.white
        labelTitle.font = UIFont.bold(size:14)
        self.labelTitle = labelTitle
        
        let labelValue:UILabel = UILabel()
        labelValue.isUserInteractionEnabled = false
        labelValue.translatesAutoresizingMaskIntoConstraints = false
        labelValue.backgroundColor = UIColor.clear
        labelValue.textColor = UIColor.white
        labelValue.font = UIFont.regular(size:16)
        self.labelValue = labelValue
        
        addSubview(labelTitle)
        addSubview(labelValue)
        
        NSLayoutConstraint.equalsVertical(
            view:labelTitle,
            toView:self)
        layoutTitleRight = NSLayoutConstraint.rightToRight(
            view:labelTitle,
            toView:self)
        NSLayoutConstraint.width(
            view:labelTitle,
            constant:kTitleWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:labelValue,
            toView:self)
        NSLayoutConstraint.leftToRight(
            view:labelValue,
            toView:labelTitle,
            constant:kValueLeft)
        NSLayoutConstraint.width(
            view:labelValue,
            constant:kValueWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.width
        let width_2:CGFloat = width / 2.0
        layoutTitleRight.constant = -width_2
        
        super.layoutSubviews()
    }
}
