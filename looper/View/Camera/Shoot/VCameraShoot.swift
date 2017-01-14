import UIKit

class VCameraShoot:VView
{
    weak var viewPreview:VCameraShootPreview!
    weak var viewMenu:VCameraShootMenu!
    weak var viewConfig:VCameraShootConfig!
    weak var viewProcess:VCameraShootProcess!
    private weak var layoutPreviewHeight:NSLayoutConstraint!
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
        NSLayoutConstraint.topToTop(
            view:viewPreview,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:viewPreview,
            toView:self)
        
        NSLayoutConstraint.height(
            view:viewMenu,
            constant:kMenuHeight)
        NSLayoutConstraint.bottomToBottom(
            view:viewMenu,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:viewMenu,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:viewConfig,
            toView:viewPreview)
        NSLayoutConstraint.bottomToBottom(
            view:viewConfig,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:viewConfig,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:viewProcess,
            toView:viewPreview)
        NSLayoutConstraint.bottomToBottom(
            view:viewProcess,
            toView:self)
        NSLayoutConstraint.equalsHorizontal(
            view:viewProcess,
            toView:self)
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
        
        if width < height
        {
            previewHeight = width
        }
        else
        {
            previewHeight = height - kMenuHeight
        }
        
        if previewHeight >= 0
        {
            layoutPreviewHeight.constant = previewHeight
        }
        
        super.layoutSubviews()
    }
    
    //MARK: public
    
    func startRecording()
    {
        viewProcess.update()
        viewProcess.isHidden = false
        viewConfig.isHidden = true
        viewMenu.startRecording()
    }
    
    func stopRecording()
    {
        viewProcess.isHidden = true
        viewConfig.isHidden = false
        viewMenu.stopRecording()
    }
}
