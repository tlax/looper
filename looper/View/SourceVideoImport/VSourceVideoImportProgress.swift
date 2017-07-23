import UIKit

class VSourceVideoImportProgress:
    View<VSourceVideoImport, MSourceVideoImport, CSourceVideoImport>
{
    private weak var layoutBarWidth:NSLayoutConstraint!
    private let kCornerRadius:CGFloat = 4
    private let kAnimationDuration:TimeInterval = 0.3
    
    required init(controller:CSourceVideoImport)
    {
        super.init(controller:controller)
        backgroundColor = UIColor(white:0, alpha:0.1)
        isUserInteractionEnabled = false
        layer.cornerRadius = kCornerRadius
        
        let viewBar:UIView = UIView()
        viewBar.translatesAutoresizingMaskIntoConstraints = false
        viewBar.isUserInteractionEnabled = false
        viewBar.clipsToBounds = true
        viewBar.backgroundColor = UIColor.colourSuccess
        
        addSubview(viewBar)
        
        NSLayoutConstraint.equalsVertical(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:viewBar,
            toView:self)
        layoutBarWidth = NSLayoutConstraint.width(
            view:viewBar)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func updateProgress(percent:CGFloat)
    {
        let width:CGFloat = bounds.width
        layoutBarWidth.constant = width * percent
        
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.layoutIfNeeded()
        }
    }
}
