import UIKit

class VSourceVideoTime:ViewMain
{
    static let kBarMaxHeight:CGFloat = 320
    static let kBottomBarHeight:CGFloat = 60
    private let kCloseTop:CGFloat = 10
    private let kCloseWidth:CGFloat = 60
    private let kCloseHeight:CGFloat = 44
    private let kCloseEdgeRight:CGFloat = 20
    
    private(set) weak var layoutBarHeight:NSLayoutConstraint!
    
    required init(controller:UIViewController)
    {
        super.init(controller:controller)
        
        guard
        
            let controller:CSourceVideoTime = self.controller as? CSourceVideoTime
        
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
    
    private func factoryViews(controller:CSourceVideoTime)
    {
        let viewBar:VSourceVideoTimeBar = VSourceVideoTimeBar(
            controller:controller)
        
        let viewBottomBar:VSourceVideoTimeBottomBar = VSourceVideoTimeBottomBar(
            controller:controller)
        
        let viewInfo:VSourceVideoTimeInfo = VSourceVideoTimeInfo(
            controller:controller)
        
        let buttonClose:UIButton = UIButton()
        buttonClose.translatesAutoresizingMaskIntoConstraints = false
        buttonClose.setImage(
            #imageLiteral(resourceName: "assetGenericClose"),
            for:UIControlState.normal)
        buttonClose.imageView!.clipsToBounds = true
        buttonClose.imageView!.contentMode = UIViewContentMode.center
        buttonClose.imageEdgeInsets = UIEdgeInsets(
            top:0,
            left:0,
            bottom:0,
            right:kCloseEdgeRight)
        buttonClose.addTarget(
            self,
            action:#selector(actionClose(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(viewInfo)
        addSubview(viewBar)
        addSubview(viewBottomBar)
        addSubview(buttonClose)
        
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        layoutBarHeight = NSLayoutConstraint.height(
            view:viewBar,
            constant:VSourceVideoTime.kBarMaxHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:viewInfo,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:viewBottomBar,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBottomBar,
            constant:VSourceVideoTime.kBottomBarHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBottomBar,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:buttonClose,
            toView:self,
            constant:kCloseTop)
        NSLayoutConstraint.height(
            view:buttonClose,
            constant:kCloseHeight)
        NSLayoutConstraint.leftToLeft(
            view:buttonClose,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonClose,
            constant:kCloseWidth)
    }
    
    //MARK: actions
    
    func actionClose(sender button:UIButton)
    {
        guard
            
            let controller:CSourceVideoTime = self.controller as? CSourceVideoTime
        
        else
        {
            return
        }
        
        controller.close()
    }
}
