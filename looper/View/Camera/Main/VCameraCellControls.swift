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
            border:false)
        self.buttonCheckAll = buttonCheckAll
        
        let buttonUncheckAll:VCameraCellControlsButton = VCameraCellControlsButton(
            image:#imageLiteral(resourceName: "assetCameraUncheckAll"),
            border:false)
        self.buttonUncheckAll = buttonUncheckAll
        
        let buttonMore:VCameraCellControlsButton = VCameraCellControlsButton(
            image:#imageLiteral(resourceName: "assetCameraMore"),
            border:true)
        self.buttonMore = buttonMore
        
        addSubview(buttonCheckAll)
        addSubview(buttonUncheckAll)
        addSubview(buttonMore)
        
        let constraintsMoreVertical:[NSLayoutConstraint] = NSLayoutConstraint.equalsVertical(
            view:buttonMore,
            toView:self)
        let constraintsCheckVertical:[NSLayoutConstraint] = NSLayoutConstraint.equalsVertical(
            view:buttonCheckAll,
            toView:self)
        let constraintsUncheckVertical:[NSLayoutConstraint] = NSLayoutConstraint.equalsVertical(
            view:buttonUncheckAll,
            toView:self)
        
        let layoutMoreWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:buttonMore,
            constant:kButtonsWidth)
        let layoutMoreRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:buttonMore,
            toView:self)
        
        let layoutCheckWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:buttonCheckAll,
            constant:kButtonsWidth)
        let layoutCheckRight:NSLayoutConstraint = NSLayoutConstraint.rightToLeft(
            view:buttonCheckAll,
            toView:buttonUncheckAll)
     
        let layoutUncheckWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:buttonUncheckAll,
            constant:kButtonsWidth)
        let layoutUncheckLeft:NSLayoutConstraint = NSLayoutConstraint.leftToRight(
            view:buttonUncheckAll,
            toView:self,
            multiplier:0.33)
        
        addConstraints(constraintsMoreVertical)
        addConstraints(constraintsCheckVertical)
        addConstraints(constraintsUncheckVertical)
        
        addConstraints([
            layoutMoreWidth,
            layoutMoreRight,
            layoutCheckWidth,
            layoutCheckRight,
            layoutUncheckWidth,
            layoutUncheckLeft])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
