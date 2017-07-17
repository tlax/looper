import UIKit

class VCameraPreview:VView
{
    weak var viewDisplay:VCameraPreviewDisplay!
    weak var viewPlayer:VCameraPreviewPlayer!
    private weak var controller:CCameraPreview!
    private weak var viewBar:VCameraPreviewBar!
    private weak var spinner:VSpinner!
    private weak var layoutDisplayHeight:NSLayoutConstraint!
    private let kBarHeight:CGFloat = 50
    private let kPlayerHeight:CGFloat = 216
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CCameraPreview
        
        let viewBar:VCameraPreviewBar = VCameraPreviewBar(controller:self.controller)
        self.viewBar = viewBar
        
        let viewDisplay:VCameraPreviewDisplay = VCameraPreviewDisplay()
        self.viewDisplay = viewDisplay
        
        let viewPlayer:VCameraPreviewPlayer = VCameraPreviewPlayer(controller:self.controller)
        self.viewPlayer = viewPlayer
        
        let spinner:VSpinner = VSpinner()
        spinner.stopAnimating()
        self.spinner = spinner
        
        addSubview(viewPlayer)
        addSubview(viewBar)
        addSubview(viewDisplay)
        addSubview(spinner)
        
        NSLayoutConstraint.bottomToBottom(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBar,
            constant:kBarHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:viewDisplay,
            toView:self)
        layoutDisplayHeight = NSLayoutConstraint.height(
            view:viewDisplay)
        NSLayoutConstraint.equalsHorizontal(
            view:viewDisplay,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:viewPlayer,
            toView:viewDisplay)
        NSLayoutConstraint.height(
            view:viewPlayer,
            constant:kPlayerHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewPlayer,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:spinner,
            toView:self)
        NSLayoutConstraint.bottomToTop(
            view:spinner,
            toView:viewBar)
        NSLayoutConstraint.equalsHorizontal(
            view:spinner,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    deinit
    {
        spinner.stopAnimating()
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        layoutDisplayHeight.constant = width
        
        super.layoutSubviews()
    }
    
    //MARK: public
    
    func saving()
    {
        spinner.startAnimating()
        viewDisplay.imageView.stopAnimating()
        viewDisplay.isHidden = true
        viewPlayer.isHidden = true
        viewBar.saving()
    }
    
    func savingFailed()
    {
        spinner.stopAnimating()
        viewDisplay.isHidden = false
        viewPlayer.isHidden = false
        viewBar.savingFailed()
    }
}
