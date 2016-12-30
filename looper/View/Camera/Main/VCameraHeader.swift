import UIKit

class VCameraHeader:UICollectionReusableView
{
    private weak var controller:CCamera?
    private weak var buttonShoot:VCameraHeaderButton!
    private weak var buttonNext:VCameraHeaderButton!
    private weak var layoutShootLeft:NSLayoutConstraint!
    private let kButtonsTop:CGFloat = 90
    private let kButtonsHeight:CGFloat = 60
    private let kButtonsWidth:CGFloat = 65
 
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
        
        let buttonNext:VCameraHeaderButton = VCameraHeaderButton(
            image:#imageLiteral(resourceName: "assetGenericNext"))
        buttonNext.addTarget(
            self,
            action:#selector(actionProcess(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonNext = buttonNext
        
        addSubview(buttonShoot)
        addSubview(buttonNext)
        
        let layoutShootTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:buttonShoot,
            toView:self,
            constant:kButtonsTop)
        let layoutShootHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:buttonShoot,
            constant:kButtonsHeight)
        layoutShootLeft = NSLayoutConstraint.leftToLeft(
            view:buttonShoot,
            toView:self)
        let layoutShootWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:buttonShoot,
            constant:kButtonsWidth)
        
        let layoutNextTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:buttonNext,
            toView:self,
            constant:kButtonsTop)
        let layoutNextHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:buttonNext,
            constant:kButtonsHeight)
        let layoutNextRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:buttonNext,
            toView:self)
        let layoutNextWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:buttonNext,
            constant:kButtonsWidth)
        
        addConstraints([
            layoutShootTop,
            layoutShootHeight,
            layoutShootLeft,
            layoutShootWidth,
            layoutNextTop,
            layoutNextHeight,
            layoutNextRight,
            layoutNextWidth])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remainButton:CGFloat = width - kButtonsWidth
        let marginButton:CGFloat = remainButton / 2.0
        layoutShootLeft.constant = marginButton
        
        super.layoutSubviews()
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
            buttonNext.notActive()
        }
        else
        {
            buttonNext.active()
        }
    }
}
