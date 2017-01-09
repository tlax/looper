import UIKit

class VCameraFilterBlenderCell:UICollectionViewCell
{
    private weak var imageView:UIImageView!
    private let kImageTop:CGFloat = 200
    private let kImageSize:CGFloat = 120
    private let kAlphaSelected:CGFloat = 1
    private let kAlphaNotSelected:CGFloat = 0.3
    private let imageRadius:CGFloat
    
    override init(frame:CGRect)
    {
        imageRadius = kImageSize / 2.0
        
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.center
        imageView.backgroundColor = UIColor.black
        imageView.layer.borderColor = UIColor(white:0.96, alpha:1).cgColor
        imageView.layer.borderWidth = 1
        self.imageView = imageView
        
        addSubview(imageView)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        imageView.layer.cornerRadius = imageRadius
        
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
            alpha = kAlphaSelected
        }
        else
        {
            alpha = kAlphaNotSelected
        }
    }
    
    //MARK: public
    
    func config(model:MCameraRecord?)
    {
        imageView.image = model?.items.first?.image
    }
}
