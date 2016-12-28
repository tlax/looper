import UIKit

class VCameraShoot:VView
{
    weak var viewPreview:VCameraShootPreview!
    weak var viewMenu:VCameraShootMenu!
    weak var viewConfig:VCameraShootConfig!
    weak var viewProcess:VCameraShootProcess!
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
        
        let viewProcess:VCameraShootProcess = VCameraShootProcess(
            controller:self.controller)
        viewProcess.isHidden = true
        self.viewProcess = viewProcess
        
        addSubview(viewConfig)
        addSubview(viewProcess)
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
        
        let layoutConfigTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:viewConfig,
            toView:viewPreview)
        layoutConfigHeight = NSLayoutConstraint.height(
            view:viewConfig)
        let layoutConfigLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewConfig,
            toView:self)
        let layoutConfigRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:viewConfig,
            toView:self)
        
        let layoutProcessTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:viewProcess,
            toView:viewPreview)
        layoutProcessHeight = NSLayoutConstraint.height(
            view:viewProcess)
        let layoutProcessLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewProcess,
            toView:self)
        let layoutProcessRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:viewProcess,
            toView:self)
        
        addConstraints([
            layoutPreviewHeight,
            layoutPreviewTop,
            layoutPreviewLeft,
            layoutPreviewRight,
            layoutMenuHeight,
            layoutMenuBottom,
            layoutMenuLeft,
            layoutMenuRight,
            layoutConfigTop,
            layoutConfigHeight,
            layoutConfigLeft,
            layoutConfigRight,
            layoutProcessTop,
            layoutProcessHeight,
            layoutProcessLeft,
            layoutProcessRight])
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
    
    //MARK: public
    
    func startRecording()
    {
        viewProcess.isHidden = false
        viewConfig.isHidden = true
    }
    
    func stopRecording()
    {
        viewProcess.isHidden = true
        viewConfig.isHidden = false
    }
}
