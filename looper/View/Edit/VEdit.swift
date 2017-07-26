import UIKit

class VEdit:ViewMain
{
    private weak var layoutSaveLeft:NSLayoutConstraint!
    private let kSaveWidth:CGFloat = 195
    private let kSaveTop:CGFloat = -32
    private let kSaveHeight:CGFloat = 64
    
    private weak var layoutBarHeight:NSLayoutConstraint!
    
    required init(controller:UIViewController)
    {
        super.init(controller:controller)
        
        guard
        
            let controller:CEdit = controller as? CEdit
        
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
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.width
        let remainSave:CGFloat = width - kSaveWidth
        let saveMarginLeft:CGFloat = remainSave / 2.0
        layoutBarHeight.constant = width
        layoutSaveLeft.constant = saveMarginLeft
        
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func factoryViews(controller:CEdit)
    {
        let viewBar:VEditBar = VEditBar(controller:controller)
        
        let viewSave:VEditSave = VEditSave(controller:controller)
        
        addSubview(viewBar)
        addSubview(viewSave)
        
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        layoutBarHeight = NSLayoutConstraint.height(
            view:viewBar)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:viewSave,
            toView:viewBar,
            constant:kSaveTop)
        NSLayoutConstraint.height(
            view:viewSave,
            constant:kSaveHeight)
        NSLayoutConstraint.width(
            view:viewSave,
            constant:kSaveWidth)
        layoutSaveLeft = NSLayoutConstraint.leftToLeft(
            view:viewSave,
            toView:self)
    }
}
