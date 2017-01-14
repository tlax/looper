import UIKit

class VCameraMoreCellClose:VCameraMoreCell
{
    private let kBorderHeight:CGFloat = 1
    private let kButtonWidth:CGFloat = 60
    private let kButtonRight:CGFloat = 20
    private let kButtonBottom:CGFloat = 10
    private let kTitleHeight:CGFloat = 50
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
     
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.medium(size:14)
        label.textColor = UIColor(white:0, alpha:0.3)
        label.text = NSLocalizedString("VCameraMoreCellClose_label", comment:"")
        
        let border:VBorder = VBorder(color:UIColor(white:0, alpha:0.1))
        
        let button:UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(
            #imageLiteral(resourceName: "assetCameraMoreClose").withRenderingMode(
                UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        button.setImage(
            #imageLiteral(resourceName: "assetCameraMoreClose").withRenderingMode(
                UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        button.imageView!.contentMode = UIViewContentMode.center
        button.imageView!.clipsToBounds = true
        button.imageView!.tintColor = UIColor(white:0, alpha:0.2)
        button.imageEdgeInsets = UIEdgeInsets(
            top:0,
            left:0,
            bottom:kButtonBottom,
            right:kButtonRight)
        button.addTarget(
            self,
            action:#selector(actionButton(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(border)
        addSubview(label)
        addSubview(button)
        
        let layoutTitleTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:label,
            toView:self)
        let layoutTitleHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:label,
            constant:kTitleHeight)
        let layoutTitleLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:label,
            toView:self)
        let layoutTitleRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:label,
            toView:self)
        
        let layoutBorderTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
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
        
        let layoutButtonTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:button,
            toView:self)
        let layoutButtonBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:button,
            toView:self)
        let layoutButtonLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:button,
            toView:self)
        let layoutButtonWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:button,
            constant:kButtonWidth)
        
        addConstraints([
            layoutTitleTop,
            layoutTitleHeight,
            layoutTitleLeft,
            layoutTitleRight,
            layoutBorderTop,
            layoutBorderHeight,
            layoutBorderLeft,
            layoutBorderRight,
            layoutButtonTop,
            layoutButtonBottom,
            layoutButtonLeft,
            layoutButtonWidth])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: actions
    
    func actionButton(sender button:UIButton)
    {
        controller?.viewMore.close(completion:nil)
    }
}
