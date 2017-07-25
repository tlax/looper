import UIKit

class VSourceVideoImport:ViewMain
{
    private(set) weak var viewProgress:VSourceVideoImportProgress!
    private let kBottomHeight:CGFloat = 200
    private let kProgressTop:CGFloat = 160
    private let kProgressHeight:CGFloat = 200
    
    required init(controller:UIViewController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        
        guard
        
            let controller:CSourceVideoImport = controller as? CSourceVideoImport
        
        else
        {
            return
        }
        
        factoryViews(controller:controller)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: private
    
    private func factoryViews(controller:CSourceVideoImport)
    {
        let viewGradient:VGradient = VGradient.vertical(
            colourTop:UIColor.colourGradientLight,
            colourBottom:UIColor.colourGradientDark)
        
        let viewBottom:VSourceVideoImportBottom = VSourceVideoImportBottom(
            controller:controller)
        
        let viewProgress:VSourceVideoImportProgress = VSourceVideoImportProgress(
            controller:controller)
        self.viewProgress = viewProgress
        
        addSubview(viewGradient)
        addSubview(viewBottom)
        addSubview(viewProgress)
        
        NSLayoutConstraint.equals(
            view:viewGradient,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:viewBottom,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBottom,
            constant:kBottomHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBottom,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:viewProgress,
            toView:self,
            constant:kProgressTop)
        NSLayoutConstraint.height(
            view:viewProgress,
            constant:kProgressHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewProgress,
            toView:self)
    }
}
