import UIKit

class VCameraHeader:UICollectionReusableView
{
    private weak var controller:CCamera?
    private weak var buttonShoot:VCameraHeaderButton!
    private weak var buttonProcess:VCameraHeaderButton!
    private weak var buttonFilter:VCameraHeaderButton!
    private let kButtonsTop:CGFloat = 80
    private let kButtonsWidth:CGFloat = 65
    private let kProcessRight:CGFloat = -5
 
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let buttonShoot:VCameraHeaderButton = VCameraHeaderButton(
            image:#imageLiteral(resourceName: "assetCameraShoot"))
        buttonShoot.addTarget(
            self,
            action:#selector(actionShoot(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonShoot = buttonShoot
        
        let buttonFilter:VCameraHeaderButton = VCameraHeaderButton(
            image:#imageLiteral(resourceName: "assetCameraFilter"))
        buttonFilter.addTarget(
            self,
            action:#selector(actionFilter(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonFilter = buttonFilter
        
        let buttonProcess:VCameraHeaderButton = VCameraHeaderButton(
            image:#imageLiteral(resourceName: "assetCameraProcess"))
        buttonProcess.addTarget(
            self,
            action:#selector(actionProcess(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonProcess = buttonProcess
        
        addSubview(buttonShoot)
        addSubview(buttonFilter)
        addSubview(buttonProcess)
        
        let layoutShootTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:buttonShoot,
            toView:self,
            constant:kButtonsTop)
        let layoutShootBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:buttonShoot,
            toView:self)
        let layoutShootRight:NSLayoutConstraint = NSLayoutConstraint.rightToLeft(
            view:buttonShoot,
            toView:buttonFilter)
        let layoutShootWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:buttonShoot,
            constant:kButtonsWidth)
        
        let layoutFilterTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:buttonFilter,
            toView:self,
            constant:kButtonsTop)
        let layoutFilterBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:buttonFilter,
            toView:self)
        let layoutFilterRight:NSLayoutConstraint = NSLayoutConstraint.rightToLeft(
            view:buttonFilter,
            toView:buttonProcess)
        let layoutFilterWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:buttonFilter,
            constant:kButtonsWidth)
        
        let layoutProcessTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:buttonProcess,
            toView:self,
            constant:kButtonsTop)
        let layoutProcessBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:buttonProcess,
            toView:self)
        let layoutProcessRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:buttonProcess,
            toView:self,
            constant:kProcessRight)
        let layoutProcessWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:buttonProcess,
            constant:kButtonsWidth)
        
        addConstraints([
            layoutShootTop,
            layoutShootBottom,
            layoutShootRight,
            layoutShootWidth,
            layoutFilterTop,
            layoutFilterBottom,
            layoutFilterRight,
            layoutFilterWidth,
            layoutProcessTop,
            layoutProcessBottom,
            layoutProcessRight,
            layoutProcessWidth])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: actions
    
    func actionShoot(sender button:VCameraHeaderButton)
    {
        guard
        
            let unlimitedRecords:Bool = MSession.sharedInstance.settings?.unlimitedRecords,
            let currentRecords:Int = controller?.model.records.count
        
        else
        {
            return
        }
        
        if !unlimitedRecords && currentRecords > MSession.kFroobMaxRecords
        {
            print("records full")
        }
        else
        {
            controller?.shoot()
        }
    }
    
    func actionFilter(sender button:VCameraHeaderButton)
    {
        
    }
    
    func actionProcess(sender button:VCameraHeaderButton)
    {
        
    }
    
    //MARK: public
    
    func config(controller:CCamera)
    {
        self.controller = controller
        
        if controller.model.records.isEmpty
        {
            buttonFilter.notActive()
            buttonProcess.notActive()
        }
        else
        {
            buttonFilter.active()
            buttonProcess.active()
        }
    }
}
