import UIKit

class VCameraFilterSelectorCellColor:VCameraFilterSelectorCell
{
    private weak var background:UIView!
    private let kMargin:CGFloat = 4
    private let kBorderWidth:CGFloat = 2
    private let kTop:CGFloat = 282
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
     
        let width:CGFloat = frame.size.width
        let circleSize:CGFloat = width - (kMargin + kMargin)
        let radius:CGFloat = circleSize / 2.0
        
        let background:UIView = UIView()
        background.isUserInteractionEnabled = false
        background.translatesAutoresizingMaskIntoConstraints = false
        background.clipsToBounds = true
        background.layer.cornerRadius = radius
        background.layer.borderWidth = kBorderWidth
        background.layer.borderColor = UIColor.genericLight.cgColor
        self.background = background
        
        addSubview(background)
        
        NSLayoutConstraint.topToTop(
            view:background,
            toView:self,
            constant:kTop)
        NSLayoutConstraint.height(
            view:background,
            constant:circleSize)
        NSLayoutConstraint.equalsHorizontal(
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
