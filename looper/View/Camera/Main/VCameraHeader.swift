import UIKit

class VCameraHeader:UICollectionReusableView
{
    private weak var controller:CCamera?
    private weak var buttonShoot:VCameraHeaderButton!
    private weak var buttonProcess:VCameraHeaderButton!
    private let kButtonsTop:CGFloat = 150
    private let kButtonsBottom:CGFloat = -35
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
        
        let buttonProcess:VCameraHeaderButton = VCameraHeaderButton(
            image:#imageLiteral(resourceName: "assetCameraProcess"))
        buttonProcess.addTarget(
            self,
            action:#selector(actionProcess(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonProcess = buttonProcess
        
        addSubview(buttonShoot)
        addSubview(buttonProcess)
        
        let layoutShootTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:buttonShoot,
            toView:self,
            constant:kButtonsTop)
        let layoutShootBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:buttonShoot,
            toView:self,
            constant:kButtonsBottom)
        let layoutShootRight:NSLayoutConstraint = NSLayoutConstraint.rightToLeft(
            view:buttonShoot,
            toView:buttonProcess)
        let layoutShootWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:buttonShoot,
            constant:kButtonsWidth)
        
        let layoutProcessTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:buttonProcess,
            toView:self,
            constant:kButtonsTop)
        let layoutProcessBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:buttonProcess,
            toView:self,
            constant:kButtonsBottom)
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
        
        if !unlimitedRecords && currentRecords >= MSession.kFroobMaxRecords
        {
            print("records full")
        }
        else
        {
            controller?.shoot()
        }
    }
    
    func actionProcess(sender button:VCameraHeaderButton)
    {
        controller?.next()
    }
    
    //MARK: public
    
    func config(controller:CCamera)
    {
        self.controller = controller
        
        if controller.model.records.isEmpty
        {
            buttonProcess.notActive()
        }
        else
        {
            buttonProcess.active()
        }
    }
}
