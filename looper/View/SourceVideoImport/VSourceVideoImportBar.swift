import UIKit

class VSourceVideoImportBar:
    View<VSourceVideoImport, MSourceVideoImport, CSourceVideoImport>
{
    private let kTitleTop:CGFloat = 20
    
    required init(controller:CSourceVideoImport)
    {
        super.init(controller:controller)
        isUserInteractionEnabled = false
        backgroundColor = UIColor.colourSuccess
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.font = UIFont.regular(size:16)
        labelTitle.textColor = UIColor.white
        labelTitle.text = String.localizedView(
            key:"VSourceVideoImportBar_labelTitle")
        
        addSubview(labelTitle)
        
        NSLayoutConstraint.topToTop(
            view:labelTitle,
            toView:self,
            constant:kTitleTop)
        NSLayoutConstraint.bottomToBottom(
            view:labelTitle,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
