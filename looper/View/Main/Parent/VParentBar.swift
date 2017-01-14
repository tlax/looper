import UIKit

class VParentBar:UIView
{
    private weak var controller:CParent!
    private weak var buttonLoops:VParentBarButton!
    private weak var buttonCamera:VParentBarButton!
    private weak var buttonStore:VParentBarButton!
    private weak var layoutLoopsLeft:NSLayoutConstraint!
    private let kButtonsWidth:CGFloat = 70
    private let kStoreRight:CGFloat = 22
    private let kCameraLeft:CGFloat = 22
    private let kBorderHeight:CGFloat = 1
    
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
            image:#imageLiteral(resourceName: "assetGenericStore"))
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
        
        let border:VBorder = VBorder(color:UIColor(white:0, alpha:0.1))
        
        addSubview(border)
        addSubview(buttonCamera)
        addSubview(buttonStore)
        addSubview(buttonLoops)
        
        NSLayoutConstraint.equalsVertical(
            view:buttonLoops,
            toView:self)
        NSLayoutConstraint.equalsVertical(
            view:buttonCamera,
            toView:self)
        NSLayoutConstraint.equalsVertical(
            view:buttonStore,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
        
        layoutLoopsLeft = NSLayoutConstraint.leftToLeft(
            view:buttonLoops,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonLoops,
            constant:kButtonsWidth)

        NSLayoutConstraint.width(
            view:buttonCamera,
            constant:kButtonsWidth)
        NSLayoutConstraint.rightToRight(
            view:buttonCamera,
            toView:self)

        NSLayoutConstraint.width(
            view:buttonStore,
            constant:kButtonsWidth)
        NSLayoutConstraint.leftToLeft(
            view:buttonStore,
            toView:self)
        
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
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
        moveToLoops()
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
    
    //MARK: public
    
    func moveToLoops()
    {
        buttonLoops.active()
        buttonCamera.notActive()
        buttonStore.notActive()
        
        controller.moveToLoops()
    }
    
    func moveToStore()
    {
        buttonLoops.notActive()
        buttonCamera.notActive()
        buttonStore.active()
        
        controller.moveToStore()
    }
}
