import UIKit

class VCameraShoot:VView
{
    weak var viewPreview:VCameraShootPreview!
    weak var viewMenu:VCameraShootMenu!
    weak var viewConfig:VCameraShootConfig!
    private weak var layoutPreviewHeight:NSLayoutConstraint!
    private weak var layoutConfigHeight:NSLayoutConstraint!
    private weak var layoutProcessHeight:NSLayoutConstraint!
    private weak var controller:CCameraShoot!
    private let kMenuHeight:CGFloat = 90
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.black
        self.controller = controller as? CCameraShoot
        
        let viewPreview:VCameraShootPreview = VCameraShootPreview()
        self.viewPreview = viewPreview
        
        let viewMenu:VCameraShootMenu = VCameraShootMenu(
            controller:self.controller)
        self.viewMenu = viewMenu
        
        let viewConfig:VCameraShootConfig = VCameraShootConfig(
            controller:self.controller)
        self.viewConfig = viewConfig
        
        addSubview(viewConfig)
        addSubview(viewPreview)
        addSubview(viewMenu)
        
        layoutPreviewHeight = NSLayoutConstraint.height(
            view:viewPreview)
        let layoutPreviewTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:viewPreview,
            toView:self)
        let layoutPreviewLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewPreview,
            toView:self)
        let layoutPreviewRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:viewPreview,
            toView:self)
        
        let layoutMenuHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:viewMenu,
            constant:kMenuHeight)
        let layoutMenuBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:viewMenu,
            toView:self)
        let layoutMenuLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewMenu,
            toView:self)
        let layoutMenuRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:viewMenu,
            toView:self)
        
        addConstraints([
            layoutPreviewHeight,
            layoutPreviewTop,
            layoutPreviewLeft,
            layoutPreviewRight,
            layoutMenuHeight,
            layoutMenuBottom,
            layoutMenuLeft,
            layoutMenuRight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let height:CGFloat = bounds.maxY
        let previewHeight:CGFloat
        let configHeight:CGFloat
        
        if width < height
        {
            previewHeight = width
            configHeight = height - (previewHeight + kMenuHeight)
        }
        else
        {
            previewHeight = height - kMenuHeight
            configHeight = 0
        }
        
        if previewHeight >= 0
        {
            layoutPreviewHeight.constant = previewHeight
        }
        
        if configHeight >= 0
        {
            layoutConfigHeight.constant = configHeight
            layoutProcessHeight.constant = configHeight
        }
        
        super.layoutSubviews()
    }
}
