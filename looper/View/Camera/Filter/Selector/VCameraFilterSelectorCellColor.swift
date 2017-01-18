import UIKit

class VCameraFilterSelectorCellColor:VCameraFilterSelectorCell
{
    private let kMargin:CGFloat = 10
    private let kCornerRadius:CGFloat = 10
    private let kBorderWidth:CGFloat = 1
    private weak var background:UIView!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let background:UIView = UIView()
        background.isUserInteractionEnabled = false
        background.translatesAutoresizingMaskIntoConstraints = false
        background.clipsToBounds = true
        background.layer.cornerRadius = kCornerRadius
        background.layer.borderWidth = kBorderWidth
        background.layer.borderColor = UIColor.genericLight.cgColor
        self.background = background
        
        addSubview(background)
        
        NSLayoutConstraint.equals(
            view:background,
            toView:self,
            margin:kMargin)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func config(model:MCameraFilterSelectorItem)
    {
        super.config(model:model)
        
        guard
        
            let model:MCameraFilterSelectorItemColor = model as? MCameraFilterSelectorItemColor
        
        else
        {
            return
        }
        
        background.backgroundColor = model.color
    }
}
