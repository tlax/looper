import UIKit

class VSourceVideoImportProgress:
    View<VSourceVideoImport, MSourceVideoImport, CSourceVideoImport>
{
    required init(controller:CSourceVideoImport)
    {
        super.init(controller:controller)
        isUserInteractionEnabled = false
        
        let viewThumb:VSourceVideoImportProgressThumb = VSourceVideoImportProgressThumb(
            controller:controller)
        
        addSubview(viewThumb)
        
        NSLayoutConstraint.equals(
            view:viewThumb,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func updateProgress(percent:CGFloat)
    {
    }
}
