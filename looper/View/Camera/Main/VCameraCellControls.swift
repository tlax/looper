import UIKit

class VCameraCellControls:UIView
{
    let kButtonsWidth:CGFloat = 60
    let allButtonsWidth:CGFloat
    weak var buttonMore:VCameraCellControlsButton!
    weak var buttonCheckAll:VCameraCellControlsButton!
    weak var buttonUncheckAll:VCameraCellControlsButton!
    
    init()
    {
        allButtonsWidth = kButtonsWidth * 3
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.genericLight
        translatesAutoresizingMaskIntoConstraints = false
        
        let buttonCheckAll:VCameraCellControlsButton = VCameraCellControlsButton(
            image:#imageLiteral(resourceName: "assetCameraCheckAll"),
            backgroundColor:UIColor.clear)
        self.buttonCheckAll = buttonCheckAll
        
        let buttonUncheckAll:VCameraCellControlsButton = VCameraCellControlsButton(
            image:#imageLiteral(resourceName: "assetCameraUncheckAll"),
            backgroundColor:UIColor.clear)
        self.buttonUncheckAll = buttonUncheckAll
        
        let buttonMore:VCameraCellControlsButton = VCameraCellControlsButton(
            image:#imageLiteral(resourceName: "assetCameraMore"),
            backgroundColor:UIColor.genericDark)
        self.buttonMore = buttonMore
        
        addSubview(buttonCheckAll)
        addSubview(buttonUncheckAll)
        addSubview(buttonMore)
        
        let layoutMoreTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:buttonMore,
            toView:self)
        let layoutMoreBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:buttonMore,
            toView:self)
        let layoutMoreWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:buttonMore,
            constant:kButtonsWidth)
        let layoutMoreRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:buttonMore,
            toView:self)
        
        let layoutCheckTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:buttonCheckAll,
            toView:self)
        let layoutCheckBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:buttonCheckAll,
            toView:self)
        let layoutCheckWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:buttonCheckAll,
            constant:kButtonsWidth)
        let layoutCheckRight:NSLayoutConstraint = NSLayoutConstraint.rightToLeft(
            view:buttonCheckAll,
            toView:buttonUncheckAll)
        
        let layoutUncheckTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:buttonUncheckAll,
            toView:self)
        let layoutUncheckBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:buttonUncheckAll,
            toView:self)
        let layoutUncheckWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:buttonUncheckAll,
            constant:kButtonsWidth)
        let layoutUncheckLeft:NSLayoutConstraint = NSLayoutConstraint.leftToRight(
            view:buttonUncheckAll,
            toView:self,
            multiplier:0.33)
        
        addConstraints([
            layoutMoreTop,
            layoutMoreBottom,
            layoutMoreWidth,
            layoutMoreRight,
            layoutCheckTop,
            layoutCheckBottom,
            layoutCheckWidth,
            layoutCheckRight,
            layoutUncheckTop,
            layoutUncheckBottom,
            layoutUncheckWidth,
            layoutUncheckLeft])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
