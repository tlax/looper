import UIKit

class VCameraMoreCellActionsOption:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private let kAlphaSelected:CGFloat = 0.3
    private let kAlphaNotSelected:CGFloat = 1
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        backgroundColor = UIColor.clear
        clipsToBounds = true
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.center
        self.imageView = imageView
        
        addSubview(imageView)
        
        let constraintsImage:[NSLayoutConstraint] = NSLayoutConstraint.equals(
            view:imageView,
            toView:self)
        
        addConstraints(constraintsImage)
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
            alpha = kAlphaSelected
        }
        else
        {
            alpha = kAlphaNotSelected
        }
    }
    
    //MARK: public
    
    func config(model:MCameraMoreItemActionsOption)
    {
        imageView.image = model.image
        hover()
    }
}
