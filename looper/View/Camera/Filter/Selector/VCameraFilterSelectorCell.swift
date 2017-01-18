import UIKit

class VCameraFilterSelectorCell:UICollectionViewCell
{
    private weak var selector:UIImageView!
    private let kSelectorTop:CGFloat = 180
    private let kSelectorHeight:CGFloat = 80
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
        NSLayoutConstraint.topToTop(
            view:selector,
            toView:self,
            constant:kSelectorTop)
        NSLayoutConstraint.height(
            view:selector,
            constant:kSelectorHeight)
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
