import UIKit

class VSourceVideoBarInfo:View<VSourceVideo, MSourceVideo, CSourceVideo>
{
    private weak var viewCellWidth:VSourceVideoBarInfoCell!
    private weak var viewCellHeight:VSourceVideoBarInfoCell!
    private weak var viewCellDuration:VSourceVideoBarInfoCell!
    private let kCellHeight:CGFloat = 40
    private let kCellTop:CGFloat = 120
    
    required init(controller:CSourceVideo)
    {
        super.init(controller:controller)
        
        let viewCellWidth:VSourceVideoBarInfoCell = VSourceVideoBarInfoCell(controller:controller)
        viewCellWidth.changeTitle(title:String.localizedView(key:"VSourceVideoBarInfo_titleWidth"))
        self.viewCellWidth = viewCellWidth
        
        let viewCellHeight:VSourceVideoBarInfoCell = VSourceVideoBarInfoCell(controller:controller)
        viewCellHeight.changeTitle(title:String.localizedView(key:"VSourceVideoBarInfo_titleHeight"))
        self.viewCellHeight = viewCellHeight
        
        let viewCellDuration:VSourceVideoBarInfoCell = VSourceVideoBarInfoCell(controller:controller)
        viewCellDuration.changeTitle(title:String.localizedView(key:"VSourceVideoBarInfo_titleDuration"))
        self.viewCellDuration = viewCellDuration
        
        addSubview(viewCellWidth)
        addSubview(viewCellHeight)
        addSubview(viewCellDuration)
        
        NSLayoutConstraint.topToTop(
            view:viewCellWidth,
            toView:self,
            constant:kCellTop)
        NSLayoutConstraint.height(
            view:viewCellWidth,
            constant:kCellHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewCellWidth,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:viewCellHeight,
            toView:viewCellWidth)
        NSLayoutConstraint.height(
            view:viewCellHeight,
            constant:kCellHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewCellHeight,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:viewCellDuration,
            toView:viewCellHeight)
        NSLayoutConstraint.height(
            view:viewCellDuration,
            constant:kCellHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewCellDuration,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func config(model:MSourceVideoItem)
    {
        
    }
}
