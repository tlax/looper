import UIKit

class VCameraHeader:UICollectionReusableView
{
    private weak var controller:CCamera?
    private weak var buttonShoot:VCameraActiveButton!
    private weak var buttonNext:VCameraActiveButton!
    private weak var layoutShootLeft:NSLayoutConstraint!
    private let kButtonsTop:CGFloat = 90
    private let kButtonsHeight:CGFloat = 60
    private let kButtonsWidth:CGFloat = 60
    private let kBorderHeight:CGFloat = 1
 
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let buttonShoot:VCameraActiveButton = VCameraActiveButton(
            image:#imageLiteral(resourceName: "assetCameraShoot"))
        buttonShoot.addTarget(
            self,
            action:#selector(actionShoot(sender:)),
            for:UIControlEvents.touchUpInside)
        buttonShoot.active()
        self.buttonShoot = buttonShoot
        
        let buttonNext:VCameraActiveButton = VCameraActiveButton(
            image:#imageLiteral(resourceName: "assetGenericNext"))
        buttonNext.addTarget(
            self,
            action:#selector(actionProcess(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonNext = buttonNext
        
        let border:UIView = UIView()
        border.isUserInteractionEnabled = false
        border.translatesAutoresizingMaskIntoConstraints = false
        border.clipsToBounds = true
        border.backgroundColor = UIColor(white:0, alpha:0.2)
        
        addSubview(border)
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
        
        let layoutBorderBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        let layoutBorderHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        let layoutBorderLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:border,
            toView:self)
        let layoutBorderRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:border,
            toView:self)
        
        addConstraints([
            layoutShootTop,
            layoutShootHeight,
            layoutShootLeft,
            layoutShootWidth,
            layoutNextTop,
            layoutNextHeight,
            layoutNextRight,
            layoutNextWidth,
            layoutBorderBottom,
            layoutBorderHeight,
            layoutBorderLeft,
            layoutBorderRight])
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
    
    func actionShoot(sender button:VCameraActiveButton)
    {
        button.notActive()
        
        guard
        
            let plus:Bool = MSession.sharedInstance.settings?.plus,
            let currentRecords:Int = MSession.sharedInstance.camera?.records.count
        
        else
        {
            button.active()
            
            return
        }
        
        if !plus && currentRecords >= MSession.kFroobMaxRecords
        {
            button.active()
            controller?.goPlus()
        }
        else
        {
            controller?.shoot()
        }
    }
    
    func actionProcess(sender button:VCameraActiveButton)
    {
        button.notActive()
        controller?.next()
    }
    
    //MARK: public
    
    func config(controller:CCamera)
    {
        self.controller = controller
        refresh()
    }
    
    func refresh()
    {
        buttonShoot.active()
        
        guard
        
            let model:MCamera = MSession.sharedInstance.camera
        
        else
        {
            buttonNext.notActive()
            
            return
        }
        
        if model.records.isEmpty
        {
            buttonNext.notActive()
        }
        else
        {
            if model.hasActive()
            {
                buttonNext.active()
            }
            else
            {
                buttonNext.notActive()
            }
        }
    }
}
