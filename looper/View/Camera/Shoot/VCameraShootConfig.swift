import UIKit

class VCameraShootConfig:UIView
{
    private weak var controller:CCameraShoot!
    private let buttonsHeight2:CGFloat
    private weak var buttonAdd:UIButton!
    private weak var buttonRest:UIButton!
    private weak var label:UILabel!
    private weak var layoutAddTop:NSLayoutConstraint!
    private let kButtonsHeight:CGFloat = 50
    private let kButtonsWidth:CGFloat = 58
    private let kButtonsMargin:CGFloat = 14
    private let kLabelWidth:CGFloat = 200
    private let kLabelRight:CGFloat = 10
    private let kTitlesHeight:CGFloat = 42
    private let kAlphaActive:CGFloat = 1
    private let kAlphaNotActive:CGFloat = 0.4
    
    init(controller:CCameraShoot)
    {
        buttonsHeight2 = kButtonsHeight + kButtonsHeight
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        self.controller = controller
        
        let buttonAdd:UIButton = UIButton()
        buttonAdd.translatesAutoresizingMaskIntoConstraints = false
        buttonAdd.setImage(
            #imageLiteral(resourceName: "assetCameraFramesAdd").withRenderingMode(
                UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonAdd.setImage(
            #imageLiteral(resourceName: "assetCameraFramesAdd").withRenderingMode(
                UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonAdd.imageView!.contentMode = UIViewContentMode.center
        buttonAdd.imageView!.clipsToBounds = true
        buttonAdd.imageView!.tintColor = UIColor(white:1, alpha:0.2)
        buttonAdd.imageEdgeInsets = UIEdgeInsets(
            top:kButtonsMargin,
            left:0,
            bottom:0,
            right:0)
        buttonAdd.addTarget(
            self,
            action:#selector(actionAdd(sender:)),
            for:UIControlEvents.touchDown)
        self.buttonAdd = buttonAdd
        
        let buttonRest:UIButton = UIButton()
        buttonRest.translatesAutoresizingMaskIntoConstraints = false
        buttonRest.setImage(
            #imageLiteral(resourceName: "assetCameraFramesRest").withRenderingMode(
                UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonRest.setImage(
            #imageLiteral(resourceName: "assetCameraFramesRest").withRenderingMode(
                UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonRest.imageView!.contentMode = UIViewContentMode.center
        buttonRest.imageView!.clipsToBounds = true
        buttonRest.imageView!.tintColor = UIColor(white:1, alpha:0.2)
        buttonRest.imageEdgeInsets = UIEdgeInsets(
            top:0,
            left:0,
            bottom:kButtonsMargin,
            right:0)
        buttonRest.addTarget(
            self,
            action:#selector(actionRest(sender:)),
            for:UIControlEvents.touchDown)
        self.buttonRest = buttonRest
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.medium(size:30)
        label.textAlignment = NSTextAlignment.right
        label.textColor = UIColor.white
        self.label = label
        
        let titleBottom:UILabel = UILabel()
        titleBottom.isUserInteractionEnabled = false
        titleBottom.backgroundColor = UIColor.clear
        titleBottom.translatesAutoresizingMaskIntoConstraints = false
        titleBottom.font = UIFont.regular(size:13)
        titleBottom.textColor = UIColor(white:1, alpha:0.7)
        titleBottom.textAlignment = NSTextAlignment.right
        titleBottom.text = NSLocalizedString(
            "VCameraShootConfig_titleBottom", comment:"")
        
        addSubview(label)
        addSubview(titleBottom)
        addSubview(buttonAdd)
        addSubview(buttonRest)
        
        NSLayoutConstraint.equalsVertical(
            view:label,
            toView:self)
        NSLayoutConstraint.rightToLeft(
            view:label,
            toView:buttonAdd,
            constant:kLabelRight)
        NSLayoutConstraint.width(
            view:label,
            constant:kLabelWidth)
        
        layoutAddTop = NSLayoutConstraint.topToTop(
            view:buttonAdd,
            toView:self)
        NSLayoutConstraint.height(
            view:buttonAdd,
            constant:kButtonsHeight)
        NSLayoutConstraint.rightToRight(
            view:buttonAdd,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonAdd,
            constant:kButtonsWidth)
        
        NSLayoutConstraint.topToBottom(
            view:buttonRest,
            toView:buttonAdd)
        NSLayoutConstraint.height(
            view:buttonRest,
            constant:kButtonsHeight)
        NSLayoutConstraint.rightToRight(
            view:buttonRest,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonRest,
            constant:kButtonsWidth)
        
        NSLayoutConstraint.topToTop(
            view:titleBottom,
            toView:buttonRest)
        NSLayoutConstraint.height(
            view:titleBottom,
            constant:kTitlesHeight)
        NSLayoutConstraint.rightToLeft(
            view:titleBottom,
            toView:buttonAdd,
            constant:kLabelRight)
        NSLayoutConstraint.width(
            view:titleBottom,
            constant:kLabelWidth)
        
        print()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let height:CGFloat = bounds.height
        let remainHeight:CGFloat = height - buttonsHeight2
        let marginTop:CGFloat = remainHeight / 2.0
        layoutAddTop.constant = marginTop
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionAdd(sender button:UIButton)
    {
        guard
            
            let model:MCamera = MSession.sharedInstance.camera
        
        else
        {
            return
        }
        
        model.currentSpeed -= 1
        
        if model.currentSpeed <= 0
        {
            model.currentSpeed = 0
            deActivateAdd()
        }
        else
        {
            activateRest()
        }
        
        print()
    }
    
    func actionRest(sender button:UIButton)
    {
        guard
            
            let model:MCamera = MSession.sharedInstance.camera
            
        else
        {
            return
        }
        
        model.currentSpeed += 1
        let maxIndex:Int = model.speeds.count - 1
        
        if model.currentSpeed >= maxIndex
        {
            model.currentSpeed = maxIndex
            deActivateRest()
        }
        else
        {
            activateAdd()
        }
        
        print()
    }
    
    //MARK: private
    
    private func print()
    {
        guard
            
            let model:MCamera = MSession.sharedInstance.camera
            
        else
        {
            return
        }
        
        let item:MCameraSpeed = model.currentSpeedModel()
        label.text = item.name
    }
    
    private func activateAdd()
    {
        buttonAdd.alpha = kAlphaActive
        buttonAdd.isUserInteractionEnabled = true
    }
    
    private func deActivateAdd()
    {
        buttonAdd.alpha = kAlphaNotActive
        buttonAdd.isUserInteractionEnabled = false
    }
    
    private func activateRest()
    {
        buttonRest.alpha = kAlphaActive
        buttonRest.isUserInteractionEnabled = true
    }
    
    private func deActivateRest()
    {
        buttonRest.alpha = kAlphaNotActive
        buttonRest.isUserInteractionEnabled = false
    }
}
