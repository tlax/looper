import UIKit

class VCameraMoreCellInfo:VCameraMoreCell
{
    private weak var label:UILabel!
    private let kMarginHorizontal:CGFloat = 10
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        isUserInteractionEnabled = false
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        self.label = label
        
        addSubview(label)
        
        NSLayoutConstraint.equalsVertical(
            view:label,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:label,
            toView:self,
            margin:kMarginHorizontal)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func config(controller:CCameraMore, model:MCameraMoreItem)
    {
        super.config(controller:controller, model:model)
        
        guard
            
            let modelInfo:MCameraMoreItemInfo = model as? MCameraMoreItemInfo
        
        else
        {
            return
        }
        
        label.attributedText = modelInfo.attributedString
    }
}
