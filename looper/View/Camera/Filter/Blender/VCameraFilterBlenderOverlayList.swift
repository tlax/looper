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
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let height:CGFloat = bounds.maxY
        let remainAddX:CGFloat = width - kButtonAddSize
        let remainAddY:CGFloat = height - kButtonAddSize
        let marginAddX:CGFloat = remainAddX / 2.0
        let marginAddY:CGFloat = remainAddY / 2.0
        layoutAddTop.constant = marginAddY
        layoutAddLeft.constant = marginAddX
        
        super.layoutSubviews()
    }
}
