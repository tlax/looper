import UIKit

class VCameraFilterBlenderOverlayList:UIView
{
    private weak var controller:CCameraFilterBlenderOverlay!
    private weak var buttonAdd:VCameraFilterBlenderOverlayListAdd!
    private weak var layoutAddTop:NSLayoutConstraint!
    private weak var layoutAddLeft:NSLayoutConstraint!
    private let kButtonAddSize:CGFloat = 80
    
    convenience init(controller:CCameraFilterBlenderOverlay)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let buttonAdd:VCameraFilterBlenderOverlayListAdd = VCameraFilterBlenderOverlayListAdd()
        self.buttonAdd = buttonAdd
        
        addSubview(buttonAdd)
        
        layoutAddTop = NSLayoutConstraint.topToTop(
            view:buttonAdd,
            toView:self)
        let layoutAddHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:buttonAdd,
            constant:kButtonAddSize)
        layoutAddLeft = NSLayoutConstraint.leftToLeft(
            view:buttonAdd,
            toView:self)
        let layoutAddWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:buttonAdd,
            constant:kButtonAddSize)
        
        addConstraints([
            layoutAddTop,
            layoutAddHeight,
            layoutAddLeft,
            layoutAddWidth])
    }
}
