import UIKit

class VCreateBar:View<VCreate, MCreate, CCreate>
{
    private let kContentTop:CGFloat = 20
    private let kContentHeight:CGFloat = 44
    private let kCloseWidth:CGFloat = 60
    private let kCloseEdgeRight:CGFloat = 20
    
    required init(controller:CCreate)
    {
        super.init(controller:controller)
        backgroundColor = UIColor(
            red:0.1,
            green:0.16,
            blue:0.19,
            alpha:1)
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.font = UIFont.regular(size:18)
        labelTitle.textColor = UIColor.white
        labelTitle.text = String.localizedView(key:"VCreateBar_labelTitle")
        
        let buttonClose:UIButton = UIButton()
        buttonClose.translatesAutoresizingMaskIntoConstraints = false
        buttonClose.setImage(
            #imageLiteral(resourceName: "assetGenericClose"),
            for:UIControlState.normal)
        buttonClose.imageView!.clipsToBounds = true
        buttonClose.imageView!.contentMode = UIViewContentMode.center
        buttonClose.imageEdgeInsets = UIEdgeInsets(
            top:0,
            left:0,
            bottom:0,
            right:kCloseEdgeRight)
        buttonClose.addTarget(
            self,
            action:#selector(actionClose(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(labelTitle)
        addSubview(buttonClose)
        
        NSLayoutConstraint.topToTop(
            view:labelTitle,
            toView:self,
            constant:kContentTop)
        NSLayoutConstraint.height(
            view:labelTitle,
            constant:kContentHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:buttonClose,
            toView:self,
            constant:kContentTop)
        NSLayoutConstraint.height(
            view:buttonClose,
            constant:kContentHeight)
        NSLayoutConstraint.leftToLeft(
            view:buttonClose,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonClose,
            constant:kCloseWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionClose(sender button:UIButton)
    {
        controller.close()
    }
}
