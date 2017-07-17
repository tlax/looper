import UIKit

class VCameraCellControls:UIView
{
    let kButtonsWidth:CGFloat = 60
    let allButtonsWidth:CGFloat
    weak var buttonMore:VCameraCellControlsButton!
    weak var buttonCheckAll:VCameraCellControlsButton!
    weak var buttonUncheckAll:VCameraCellControlsButton!
    private let kUncheckMultiplier:CGFloat = 0.33
    
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
        
        NSLayoutConstraint.equalsVertical(
            view:buttonMore,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonMore,
            constant:kButtonsWidth)
        NSLayoutConstraint.rightToRight(
            view:buttonMore,
            toView:self)
        
        NSLayoutConstraint.equalsVertical(
            view:buttonCheckAll,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonCheckAll,
            constant:kButtonsWidth)
        NSLayoutConstraint.rightToLeft(
            view:buttonCheckAll,
            toView:buttonUncheckAll)
        
        NSLayoutConstraint.equalsVertical(
            view:buttonUncheckAll,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonUncheckAll,
            constant:kButtonsWidth)
        NSLayoutConstraint.leftToRight(
            view:buttonUncheckAll,
            toView:self,
            multiplier:kUncheckMultiplier)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
