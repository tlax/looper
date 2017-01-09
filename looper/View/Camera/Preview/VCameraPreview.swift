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
    private let kPlayerHeight:CGFloat = 195
    
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
        
        let layoutBarBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:viewBar,
            toView:self)
        let layoutBarHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:viewBar,
            constant:kBarHeight)
        let layoutBarLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewBar,
            toView:self)
        let layoutBarRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:viewBar,
            toView:self)
        
        let layoutDisplayTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:viewDisplay,
            toView:self)
        layoutDisplayHeight = NSLayoutConstraint.height(
            view:viewDisplay)
        let layoutDisplayLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewDisplay,
            toView:self)
        let layoutDisplayRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:viewDisplay,
            toView:self)
        
        let layoutPlayerTop:NSLayoutConstraint = NSLayoutConstraint.topToBottom(
            view:viewPlayer,
            toView:viewDisplay)
        let layoutPlayerHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:viewPlayer,
            constant:kPlayerHeight)
        let layoutPlayerLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewPlayer,
            toView:self)
        let layoutPlayerRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:viewPlayer,
            toView:self)
        
        let layoutSpinnerTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:spinner,
            toView:self)
        let layoutSpinnerBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToTop(
            view:spinner,
            toView:viewBar)
        let layoutSpinnerLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:spinner,
            toView:self)
        let layoutSpinnerRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:spinner,
            toView:self)
        
        addConstraints([
            layoutBarBottom,
            layoutBarHeight,
            layoutBarLeft,
            layoutBarRight,
            layoutDisplayTop,
            layoutDisplayHeight,
            layoutDisplayLeft,
            layoutDisplayRight,
            layoutPlayerTop,
            layoutPlayerHeight,
            layoutPlayerLeft,
            layoutPlayerRight,
            layoutSpinnerTop,
            layoutSpinnerBottom,
            layoutSpinnerLeft,
            layoutSpinnerRight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
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
