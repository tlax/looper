import UIKit

class VSourceVideoImportProgress:
    View<VSourceVideoImport, MSourceVideoImport, CSourceVideoImport>
{
    private weak var viewBar:VSourceVideoImportProgressBar!
    
    required init(controller:CSourceVideoImport)
    {
        super.init(controller:controller)
        isUserInteractionEnabled = false
        
        let viewBar:VSourceVideoImportProgressBar = VSourceVideoImportProgressBar(
            controller:controller)
        self.viewBar = viewBar
        
        let viewThumb:VSourceVideoImportProgressThumb = VSourceVideoImportProgressThumb(
            controller:controller)
        
        addSubview(viewBar)
        addSubview(viewThumb)
        
        NSLayoutConstraint.equals(
            view:viewBar,
            toView:self)
        
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
        viewBar.update(percent:percent)
    }
}
