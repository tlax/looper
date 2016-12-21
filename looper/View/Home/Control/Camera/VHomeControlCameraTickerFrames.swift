import UIKit

class VHomeControlCameraTickerFrames:UIView
{
    private let model:MHomeFrames
    private let buttonsHeight2:CGFloat
    private var currentIndex:Int
    private weak var controller:CHome!
    private weak var buttonAdd:UIButton!
    private weak var buttonRest:UIButton!
    private weak var label:UILabel!
    private weak var layoutAddTop:NSLayoutConstraint!
    private let kButtonsHeight:CGFloat = 35
    private let kButtonsWidth:CGFloat = 50
    private let kLabelWidth:CGFloat = 70
    private let kAlphaActive:CGFloat = 1
    private let kAlphaNotActive:CGFloat = 0.2
    
    init(controller:CHome)
    {
        model = MHomeFrames()
        currentIndex = model.kInitial
        buttonsHeight2 = kButtonsHeight + kButtonsHeight
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        
        let buttonAdd:UIButton = UIButton()
        buttonAdd.translatesAutoresizingMaskIntoConstraints = false
        buttonAdd.setImage(
            #imageLiteral(resourceName: "assetHomeCameraFramesAdd").withRenderingMode(
                UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonAdd.setImage(
            #imageLiteral(resourceName: "assetHomeCameraFramesAdd").withRenderingMode(
                UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonAdd.imageView!.contentMode = UIViewContentMode.center
        buttonAdd.imageView!.clipsToBounds = true
        buttonAdd.imageView!.tintColor = UIColor(white:1, alpha:0.2)
        buttonAdd.addTarget(
            self,
            action:#selector(self.actionAdd(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonAdd = buttonAdd
        
        let buttonRest:UIButton = UIButton()
        buttonRest.translatesAutoresizingMaskIntoConstraints = false
        buttonRest.setImage(
            #imageLiteral(resourceName: "assetHomeCameraFramesRest").withRenderingMode(
                UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonRest.setImage(
            #imageLiteral(resourceName: "assetHomeCameraFramesRest").withRenderingMode(
                UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonRest.imageView!.contentMode = UIViewContentMode.center
        buttonRest.imageView!.clipsToBounds = true
        buttonRest.imageView!.tintColor = UIColor(white:1, alpha:0.2)
        buttonRest.addTarget(
            self,
            action:#selector(self.actionRest(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonRest = buttonRest
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.medium(size:30)
        label.textAlignment = NSTextAlignment.right
        label.textColor = UIColor.white
        self.label = label
        
        addSubview(buttonAdd)
        addSubview(buttonRest)
        addSubview(label)
        
        layoutAddTop = NSLayoutConstraint.topToTop(
            view:buttonAdd,
            toView:self)
        let layoutAddHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:buttonAdd,
            constant:kButtonsHeight)
        let layoutAddRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:buttonAdd,
            toView:self)
        let layoutAddWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:buttonAdd,
            constant:kButtonsWidth)
        
        let layoutRestTop:NSLayoutConstraint = NSLayoutConstraint.topToBottom(
            view:buttonRest,
            toView:buttonAdd)
        let layoutRestHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:buttonRest,
            constant:kButtonsHeight)
        let layoutRestRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:buttonRest,
            toView:self)
        let layoutRestWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:buttonRest,
            constant:kButtonsWidth)
        
        let layoutLabelTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:label,
            toView:self)
        let layoutLabelBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:label,
            toView:self)
        let layoutLabelRight:NSLayoutConstraint = NSLayoutConstraint.rightToLeft(
            view:label,
            toView:buttonAdd)
        let layoutLabelWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:label,
            constant:kLabelWidth)
        
        addConstraints([
            layoutAddTop,
            layoutAddHeight,
            layoutAddRight,
            layoutAddWidth,
            layoutRestTop,
            layoutRestHeight,
            layoutRestRight,
            layoutRestWidth,
            layoutLabelTop,
            layoutLabelBottom,
            layoutLabelRight,
            layoutLabelWidth])
        
        print()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
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
        currentIndex -= 1
        
        if currentIndex <= 0
        {
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
        currentIndex += 1
        
        if currentIndex >= model.items.count - 1
        {
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
        let item:MHomeFramesItem = model.items[currentIndex]
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
    
    //MARK: public
    
    func blockButtons()
    {
        deActivateAdd()
        deActivateRest()
    }
    
    func releaseButtons()
    {
        if currentIndex > 0
        {
            activateAdd()
        }
        
        if currentIndex < model.items.count - 1
        {
            activateRest()
        }
    }
    
    func timeInterval() -> TimeInterval
    {
        let item:MHomeFramesItem = model.items[currentIndex]
        
        return item.timeInterval
    }
}
