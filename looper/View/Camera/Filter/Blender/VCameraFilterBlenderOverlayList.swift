import UIKit

class VCameraFilterBlenderOverlayList:UIView
{
    private weak var controller:CCameraFilterBlenderOverlay!
    private weak var buttonAdd:VCameraFilterBlenderOverlayListAdd!
    private let kAfterInit:TimeInterval = 1
    private let kButtonAddSize:CGFloat = 80
    private let kButtonAddTop:CGFloat = 10
    
    convenience init(controller:CCameraFilterBlenderOverlay)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let buttonAdd:VCameraFilterBlenderOverlayListAdd = VCameraFilterBlenderOverlayListAdd()
        buttonAdd.addTarget(
            self,
            action:#selector(actionAdd(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonAdd = buttonAdd
        
        addSubview(buttonAdd)
        
        let layoutAddTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:buttonAdd,
            toView:self,
            constant:kButtonAddTop)
        let layoutAddHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:buttonAdd,
            constant:kButtonAddSize)
        buttonAdd.layoutLeft = NSLayoutConstraint.leftToLeft(
            view:buttonAdd,
            toView:self,
            constant:-kButtonAddSize)
        let layoutAddWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:buttonAdd,
            constant:kButtonAddSize)
        
        addConstraints([
            layoutAddTop,
            layoutAddHeight,
            buttonAdd.layoutLeft,
            layoutAddWidth])
        
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kAfterInit)
        { [weak self] in
            
            self?.buttonAdd.animateShow()
        }
    }
    
    //MARK: actions
    
    func actionAdd(sender button:UIButton)
    {
        buttonAdd.animateHide()
    }
}
