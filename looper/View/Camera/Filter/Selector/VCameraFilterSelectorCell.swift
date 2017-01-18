import UIKit

class VCameraFilterSelectorCell:UICollectionViewCell
{
    private weak var selector:UIImageView!
    private weak var layoutSelectorBottom:NSLayoutConstraint!
    private let kSelectorHeight:CGFloat = 220
    private let kAlphaSelected:CGFloat = 1
    private let kAlphaNotSelected:CGFloat = 0.2
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let selector:UIImageView = UIImageView()
        selector.isUserInteractionEnabled = false
        selector.translatesAutoresizingMaskIntoConstraints = false
        selector.clipsToBounds = true
        selector.image = #imageLiteral(resourceName: "assetCameraFilterBlenderSelect")
        selector.contentMode = UIViewContentMode.center
        self.selector = selector
        
        addSubview(selector)
        
        NSLayoutConstraint.equalsHorizontal(
            view:selector,
            toView:self)
        layoutSelectorBottom = NSLayoutConstraint.bottomToBottom(
            view:selector,
            toView:self)
        NSLayoutConstraint.height(
            view:selector,
            constant:kSelectorHeight)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let height:CGFloat = bounds.maxY
        let height_2:CGFloat = height / 2.0
        
        layoutSelectorBottom.constant = -height_2
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
            selector.isHidden = false
        }
        else
        {
            alpha = kAlphaNotSelected
            selector.isHidden = true
        }
    }
    
    //MARK: public
    
    func config(model:MCameraFilterSelectorItem)
    {
        hover()
    }
}
