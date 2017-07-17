import UIKit

class VCameraHeader:UICollectionReusableView
{
    private weak var controller:CCamera?
    private weak var buttonShoot:VCameraActiveButton!
    private weak var buttonPicture:VCameraActiveButton!
    private weak var buttonVideo:VCameraActiveButton!
    private weak var buttonNext:VCameraActiveButton!
    private let kButtonsTop:CGFloat = 90
    private let kButtonsSize:CGFloat = 62
    private let kBorderHeight:CGFloat = 1
 
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let buttonHelp:UIButton = UIButton()
        buttonHelp.translatesAutoresizingMaskIntoConstraints = false
        buttonHelp.setImage(
            #imageLiteral(resourceName: "assetLoopsHelp").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonHelp.setImage(
            #imageLiteral(resourceName: "assetLoopsHelp").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonHelp.imageView!.contentMode = UIViewContentMode.center
        buttonHelp.imageView!.clipsToBounds = true
        buttonHelp.imageView!.tintColor = UIColor.genericAlternative
        buttonHelp.addTarget(
            self,
            action:#selector(actionHelp(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonShoot:VCameraActiveButton = VCameraActiveButton(
            image:#imageLiteral(resourceName: "assetCameraShoot"))
        buttonShoot.addTarget(
            self,
            action:#selector(actionShoot(sender:)),
            for:UIControlEvents.touchUpInside)
        buttonShoot.active()
        self.buttonShoot = buttonShoot
        
        let buttonPicture:VCameraActiveButton = VCameraActiveButton(
            image:#imageLiteral(resourceName: "assetCameraPicture"))
        buttonPicture.addTarget(
            self,
            action:#selector(actionPicture(sender:)),
            for:UIControlEvents.touchUpInside)
        buttonPicture.active()
        self.buttonPicture = buttonPicture
        
        let buttonVideo:VCameraActiveButton = VCameraActiveButton(
            image:#imageLiteral(resourceName: "assetCameraVideo"))
        buttonVideo.addTarget(
            self,
            action:#selector(actionVideo(sender:)),
            for:UIControlEvents.touchUpInside)
        buttonVideo.active()
        self.buttonPicture = buttonPicture
        
        let buttonNext:VCameraActiveButton = VCameraActiveButton(
            image:#imageLiteral(resourceName: "assetCameraNext"))
        buttonNext.addTarget(
            self,
            action:#selector(actionProcess(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonNext = buttonNext
        
        let border:VBorder = VBorder(color:UIColor(white:0, alpha:0.2))
        
        addSubview(border)
        addSubview(buttonHelp)
        addSubview(buttonShoot)
        addSubview(buttonPicture)
        addSubview(buttonVideo)
        addSubview(buttonNext)
        
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        
        NSLayoutConstraint.topToTop(
            view:buttonHelp,
            toView:self,
            constant:kButtonsTop)
        NSLayoutConstraint.size(
            view:buttonHelp,
            constant:kButtonsSize)
        NSLayoutConstraint.leftToLeft(
            view:buttonHelp,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:buttonShoot,
            toView:self,
            constant:kButtonsTop)
        NSLayoutConstraint.size(
            view:buttonShoot,
            constant:kButtonsSize)
        NSLayoutConstraint.leftToRight(
            view:buttonShoot,
            toView:buttonHelp)
        
        NSLayoutConstraint.topToTop(
            view:buttonPicture,
            toView:self,
            constant:kButtonsTop)
        NSLayoutConstraint.size(
            view:buttonPicture,
            constant:kButtonsSize)
        NSLayoutConstraint.leftToRight(
            view:buttonPicture,
            toView:buttonShoot)
        
        NSLayoutConstraint.topToTop(
            view:buttonVideo,
            toView:self,
            constant:kButtonsTop)
        NSLayoutConstraint.size(
            view:buttonPicture,
            constant:kButtonsSize)
        NSLayoutConstraint.leftToRight(
            view:buttonVideo,
            toView:buttonPicture)
        
        NSLayoutConstraint.topToTop(
            view:buttonNext,
            toView:self,
            constant:kButtonsTop)
        NSLayoutConstraint.size(
            view:buttonNext,
            constant:kButtonsSize)
        NSLayoutConstraint.leftToRight(
            view:buttonNext,
            toView:buttonVideo)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionHelp(sender button:UIButton)
    {
        controller?.help()
    }
    
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
    
    func actionPicture(sender button:VCameraActiveButton)
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
            controller?.picker(record:nil)
        }
    }
    
    func actionVideo(sender button:VCameraActiveButton)
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
            controller?.video()
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
        buttonPicture.active()
        buttonVideo.active()
        
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
