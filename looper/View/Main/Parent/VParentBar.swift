import UIKit

class VParentBar:UIView
{
    private weak var controller:CParent!
    private weak var buttonLoops:VParentBarButton!
    private weak var buttonCamera:VParentBarButton!
    private weak var buttonStore:VParentBarButton!
    private weak var layoutLoopsLeft:NSLayoutConstraint!
    private let kButtonsWidth:CGFloat = 70
    private let kStoreRight:CGFloat = 25
    private let kCameraLeft:CGFloat = 25
    
    convenience init(controller:CParent)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let buttonLoops:VParentBarButton = VParentBarButton(
            image:#imageLiteral(resourceName: "assetGenericLoops"))
        buttonLoops.addTarget(
            self,
            action:#selector(actionLoops(sender:)),
            for:UIControlEvents.touchUpInside)
        buttonLoops.active()
        self.buttonLoops = buttonLoops
        
        let buttonCamera:VParentBarButton = VParentBarButton(
            image:#imageLiteral(resourceName: "assetGenericCamera"))
        buttonCamera.addTarget(
            self,
            action:#selector(actionCamera(sender:)),
            for:UIControlEvents.touchUpInside)
        buttonCamera.imageEdgeInsets = UIEdgeInsets(
            top:buttonCamera.imageEdgeInsets.top,
            left:buttonCamera.imageEdgeInsets.left + kCameraLeft,
            bottom:buttonCamera.imageEdgeInsets.bottom,
            right:buttonCamera.imageEdgeInsets.right)
        self.buttonCamera = buttonCamera
        
        let buttonStore:VParentBarButton = VParentBarButton(
            image:#imageLiteral(resourceName: "assetHomeCamera"))
        buttonStore.addTarget(
            self,
            action:#selector(actionStore(sender:)),
            for:UIControlEvents.touchUpInside)
        buttonStore.imageEdgeInsets = UIEdgeInsets(
            top:buttonStore.imageEdgeInsets.top,
            left:buttonStore.imageEdgeInsets.left,
            bottom:buttonStore.imageEdgeInsets.bottom,
            right:buttonStore.imageEdgeInsets.right + kStoreRight)
        self.buttonStore = buttonStore
        
        addSubview(buttonCamera)
        addSubview(buttonStore)
        addSubview(buttonLoops)
        
        let layoutLoopsTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:buttonLoops,
            toView:self)
        let layoutLoopsBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:buttonLoops,
            toView:self)
        layoutLoopsLeft = NSLayoutConstraint.leftToLeft(
            view:buttonLoops,
            toView:self)
        let layoutLoopsWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:buttonLoops,
            constant:kButtonsWidth)
        
        let layoutCameraTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:buttonCamera,
            toView:self)
        let layoutCameraBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:buttonCamera,
            toView:self)
        let layoutCameraWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:buttonCamera,
            constant:kButtonsWidth)
        let layoutCameraRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:buttonCamera,
            toView:self)
        
        let layoutStoreTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:buttonStore,
            toView:self)
        let layoutStoreBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:buttonStore,
            toView:self)
        let layoutStoreWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:buttonStore,
            constant:kButtonsWidth)
        let layoutStoreLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:buttonStore,
            toView:self)
        
        addConstraints([
            layoutLoopsTop,
            layoutLoopsBottom,
            layoutLoopsLeft,
            layoutLoopsWidth,
            layoutCameraTop,
            layoutCameraBottom,
            layoutCameraRight,
            layoutCameraWidth,
            layoutStoreTop,
            layoutStoreBottom,
            layoutStoreWidth,
            layoutStoreLeft])
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remainLoops:CGFloat = width - kButtonsWidth
        let marginLoops:CGFloat = remainLoops / 2.0
        layoutLoopsLeft.constant = marginLoops
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionLoops(sender button:VParentBarButton)
    {
        button.active()
        buttonCamera.notActive()
        buttonStore.notActive()
        
        controller.moveToLoops()
    }
    
    func actionCamera(sender button:VParentBarButton)
    {
        button.active()
        buttonLoops.notActive()
        buttonStore.notActive()
        
        controller.moveToCamera()
    }
    
    func actionStore(sender button:VParentBarButton)
    {
        button.active()
        buttonCamera.notActive()
        buttonLoops.notActive()
        
        controller.moveToStore()
    }
}
