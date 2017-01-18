import UIKit

class VCameraFilterCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private weak var baseView:UIImageView!
    private weak var label:UILabel!
    private let kLabelMargin:CGFloat = 10
    private let kLabelHeight:CGFloat = 45
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.white
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        self.imageView = imageView
        
        let baseView:UIImageView = UIImageView()
        baseView.isUserInteractionEnabled = false
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.clipsToBounds = true
        baseView.contentMode = UIViewContentMode.center
        self.baseView = baseView
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.bold(size:14)
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 0
        self.label = label
        
        addSubview(label)
        addSubview(baseView)
        addSubview(imageView)
        
        NSLayoutConstraint.equals(
            view:baseView,
            toView:self)
        NSLayoutConstraint.equals(
            view:imageView,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:label,
            toView:self)
        NSLayoutConstraint.height(
            view:label,
            constant:kLabelHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:label,
            toView:self,
            margin:kLabelMargin)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
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
            baseView.image = #imageLiteral(resourceName: "assetFilterBaseSelected")
        }
        else
        {
            baseView.image = #imageLiteral(resourceName: "assetFilterBase")
        }
    }
    
    //MARK: public
    
    func config(model:MCameraFilterItem)
    {
        imageView.image = model.image
        label.text = model.title
        
        hover()
    }
}
