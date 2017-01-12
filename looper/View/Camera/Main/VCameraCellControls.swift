import UIKit

class VCameraCellControls:UIView
{
    weak var buttonTrash:VCameraCellControlsButton!
    weak var buttonCheckAll:VCameraCellControlsButton!
    weak var buttonUncheckAll:VCameraCellControlsButton!
    private let kButtonsWidth:CGFloat = 60
    
    init()
    {
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
        
        let buttonTrash:VCameraCellControlsButton = VCameraCellControlsButton(
            image:#imageLiteral(resourceName: "assetCameraTrash"),
            backgroundColor:UIColor(white:0.8, alpha:1))
        self.buttonTrash = buttonTrash
        
        addSubview(buttonCheckAll)
        addSubview(buttonUncheckAll)
        addSubview(buttonTrash)
        
        let layoutTrashTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:buttonTrash,
            toView:self)
        let layoutTrashBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:buttonTrash,
            toView:self)
        let layoutTrashWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:buttonTrash,
            constant:kButtonsWidth)
        let layoutTrashRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:buttonTrash,
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
            layoutTrashTop,
            layoutTrashBottom,
            layoutTrashWidth,
            layoutTrashRight,
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
