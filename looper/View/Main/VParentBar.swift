import UIKit

class VParentBar:UIView
{
    private weak var controller:CParent!
    private weak var buttonLoops:VParentBarButton!
    private weak var buttonCamera:VParentBarButton!
    private weak var buttonStore:VParentBarButton!
    private weak var layoutLoopsLeft:NSLayoutConstraint!
    private let kButtonsWidth:CGFloat = 60
    
    convenience init(controller:CParent)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let buttonLoops:VParentBarButton = VParentBarButton(image:#imageLiteral(resourceName: "assetHomeCamera"))
        self.buttonLoops = buttonLoops
        
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
        
        addConstraints([
            layoutLoopsTop,
            layoutLoopsBottom,
            layoutLoopsLeft,
            layoutLoopsWidth])
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remainLoops:CGFloat = width - kButtonsWidth
        let marginLoops:CGFloat = remainLoops / 2.0
        layoutLoopsLeft.constant = marginLoops
        
        super.layoutSubviews()
    }
}
