import UIKit

class VCameraCellControls:UIView
{
    weak var buttonTrash:UIButton!
    weak var buttonCheckAll:UIButton!
    weak var buttonUncheckAll:UIButton!
    private let kButtonsWidth:CGFloat = 60
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.genericLight
        translatesAutoresizingMaskIntoConstraints = false
        
        let buttonCheckAll:UIButton = UIButton()
        buttonCheckAll.translatesAutoresizingMaskIntoConstraints = false
        buttonCheckAll.setImage(
            #imageLiteral(resourceName: "assetCameraCheckAll").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonCheckAll.setImage(
            #imageLiteral(resourceName: "assetCameraCheckAll").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonCheckAll.imageView!.tintColor = UIColor(white:0, alpha:0.1)
        buttonCheckAll.imageView!.clipsToBounds = true
        buttonCheckAll.imageView!.contentMode = UIViewContentMode.center
        self.buttonCheckAll = buttonCheckAll
        
        let buttonUncheckAll:UIButton = UIButton()
        buttonUncheckAll.translatesAutoresizingMaskIntoConstraints = false
        buttonUncheckAll.setImage(
            #imageLiteral(resourceName: "assetCameraUncheckAll").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonUncheckAll.setImage(
            #imageLiteral(resourceName: "assetCameraUncheckAll").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonUncheckAll.imageView!.tintColor = UIColor(white:0, alpha:0.1)
        buttonUncheckAll.imageView!.clipsToBounds = true
        buttonUncheckAll.imageView!.contentMode = UIViewContentMode.center
        self.buttonUncheckAll = buttonUncheckAll
        
        let buttonTrash:UIButton = UIButton()
        buttonTrash.translatesAutoresizingMaskIntoConstraints = false
        buttonTrash.setImage(
            #imageLiteral(resourceName: "assetCameraTrash").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonTrash.setImage(
            #imageLiteral(resourceName: "assetCameraTrash").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonTrash.imageView!.tintColor = UIColor(white:0, alpha:0.1)
        buttonTrash.imageView!.clipsToBounds = true
        buttonTrash.imageView!.contentMode = UIViewContentMode.center
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
            toView:buttonTrash)
        
        let layoutUncheckTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:buttonUncheckAll,
            toView:self)
        let layoutUncheckBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:buttonUncheckAll,
            toView:self)
        let layoutUncheckWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:buttonUncheckAll,
            constant:kButtonsWidth)
        let layoutUncheckRight:NSLayoutConstraint = NSLayoutConstraint.rightToLeft(
            view:buttonUncheckAll,
            toView:buttonCheckAll)
        
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
            layoutUncheckRight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
