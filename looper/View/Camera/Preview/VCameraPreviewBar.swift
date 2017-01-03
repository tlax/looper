import UIKit

class VCameraPreviewBar:UIView
{
    private weak var controller:CCameraPreview!
    private weak var backButton:UIButton!
    private weak var saveButton:UIButton!
    private weak var cancelButton:UIButton!
    private weak var layoutSaveLeft:NSLayoutConstraint!
    private let kBackWidth:CGFloat = 55
    private let kSaveWidth:CGFloat = 120
    private let kCancelWidth:CGFloat = 80
    private let kAlphaSaving:CGFloat = 0.3
    private let kAlphaNotSaving:CGFloat = 1
    
    convenience init(controller:CCameraPreview)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        self.controller = controller
        
        let backButton:UIButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        backButton.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        backButton.imageView!.contentMode = UIViewContentMode.center
        backButton.imageView!.clipsToBounds = true
        backButton.imageView!.tintColor = UIColor(white:0, alpha:0.2)
        backButton.addTarget(
            self,
            action:#selector(actionBack(sender:)),
            for:UIControlEvents.touchUpInside)
        self.backButton = backButton
        
        let cancelButton:UIButton = UIButton()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle(
            NSLocalizedString("VCameraPreviewBar_cancelButton", comment:""),
            for:UIControlState.normal)
        cancelButton.setTitleColor(
            UIColor(red:1, green:0.1, blue:0, alpha:1),
            for:UIControlState.normal)
        cancelButton.setTitleColor(
            UIColor(white:0, alpha:0.2),
            for:UIControlState.highlighted)
        cancelButton.titleLabel!.font = UIFont.bold(size:14)
        cancelButton.addTarget(
            self,
            action:#selector(actionCancel(sender:)),
            for:UIControlEvents.touchUpInside)
        self.cancelButton = cancelButton
        
        let saveButton:UIButton = UIButton()
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle(
            NSLocalizedString("VCameraPreviewBar_saveButton", comment:""),
            for:UIControlState.normal)
        saveButton.setTitleColor(
            UIColor.genericLight,
            for:UIControlState.normal)
        saveButton.setTitleColor(
            UIColor(white:0, alpha:0.2),
            for:UIControlState.highlighted)
        saveButton.titleLabel!.font = UIFont.bold(size:19)
        saveButton.addTarget(
            self,
            action:#selector(actionSave(sender:)),
            for:UIControlEvents.touchUpInside)
        self.saveButton = saveButton
        
        addSubview(backButton)
        addSubview(cancelButton)
        addSubview(saveButton)
        
        let layoutBackTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:backButton,
            toView:self)
        let layoutBackBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:backButton,
            toView:self)
        let layoutBackLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:backButton,
            toView:self)
        let layoutBackWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:backButton,
            constant:kBackWidth)
        
        let layoutCancelTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:cancelButton,
            toView:self)
        let layoutCancelBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:cancelButton,
            toView:self)
        let layoutCancelRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:cancelButton,
            toView:self)
        let layoutCancelWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:cancelButton,
            constant:kCancelWidth)
        
        let layoutSaveTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:saveButton,
            toView:self)
        let layoutSaveBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:saveButton,
            toView:self)
        layoutSaveLeft = NSLayoutConstraint.leftToLeft(
            view:saveButton,
            toView:self)
        let layoutSaveWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:saveButton,
            constant:kSaveWidth)
        
        addConstraints([
            layoutBackTop,
            layoutBackBottom,
            layoutBackLeft,
            layoutBackWidth,
            layoutCancelTop,
            layoutCancelBottom,
            layoutCancelRight,
            layoutCancelWidth,
            layoutSaveTop,
            layoutSaveBottom,
            layoutSaveLeft,
            layoutSaveWidth])
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remainSave:CGFloat = width - kSaveWidth
        let marginSave:CGFloat = remainSave / 2.0
        layoutSaveLeft.constant = marginSave
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionBack(sender button:UIButton)
    {
        controller.back()
    }
    
    func actionCancel(sender button:UIButton)
    {
        controller.cancel()
    }
    
    func actionSave(sender button:UIButton)
    {
        controller.save()
    }
    
    //MARK: public
    
    func saving()
    {
        isUserInteractionEnabled = false
        backButton.alpha = kAlphaSaving
        saveButton.alpha = kAlphaSaving
        cancelButton.alpha = kAlphaSaving
    }
    
    func savingFailed()
    {
        isUserInteractionEnabled = true
        backButton.alpha = kAlphaNotSaving
        saveButton.alpha = kAlphaNotSaving
        cancelButton.alpha = kAlphaNotSaving
    }
}
