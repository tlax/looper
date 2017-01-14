import UIKit

class VHelpCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private weak var label:UILabel!
    private let kImageTop:CGFloat = 100
    private let kImageHeight:CGFloat = 160
    private let kLabelHeight:CGFloat = 110
    private let kLabelMargin:CGFloat = 10
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = false
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.center
        imageView.clipsToBounds = true
        self.imageView = imageView
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.regular(size:20)
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 0
        label.textColor = UIColor.black
        self.label = label
        
        addSubview(imageView)
        addSubview(label)
        
        let constraintsImageHorizontal:[NSLayoutConstraint] = NSLayoutConstraint.equalsHorizontal(
            view:imageView,
            toView:self)
        let constraintsLabelHorizontal:[NSLayoutConstraint] = NSLayoutConstraint.equalsHorizontal(
            view:label,
            toView:self,
            margin:kLabelMargin)
        
        let layoutImageTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self,
            constant:kImageTop)
        let layoutImageHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:imageView,
            constant:kImageHeight)
        
        let layoutLabelTop:NSLayoutConstraint = NSLayoutConstraint.topToBottom(
            view:label,
            toView:imageView)
        let layoutLabelHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:label,
            constant:kLabelHeight)
        
        addConstraints(constraintsImageHorizontal)
        addConstraints(constraintsLabelHorizontal)
        
        addConstraints([
            layoutImageTop,
            layoutImageHeight,
            layoutLabelTop,
            layoutLabelHeight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func config(model:MHelpItem)
    {
        imageView.image = model.image
        label.text = model.title
    }
}
