import UIKit

class VSourceVideoTimeBar:
View<VSourceVideoTime, MSourceVideoTime, CSourceVideoTime>
{
    private weak var layoutThumbLeft:NSLayoutConstraint!
    private let kThumbTop:CGFloat = 60
    private let kThumbSize:CGFloat = 128
    private let kInfoHeight:CGFloat = 100
    private let kImageAlpha:CGFloat = 0.1
    private let kBlurAlpha:CGFloat = 0.95
    private let kCloseWidth:CGFloat = 70
    private let kCloseHeight:CGFloat = 64
    private let kCloseEdgeRight:CGFloat = 25
    private let kBorderHeight:CGFloat = 1
    
    required init(controller:CSourceVideoTime)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.colourSuccess
        
        let border:VBorder = VBorder(colour:UIColor(white:0, alpha:0.2))
        
        let backgroundImage:UIImageView = UIImageView()
        backgroundImage.isUserInteractionEnabled = false
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.clipsToBounds = true
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        backgroundImage.alpha = kImageAlpha
        backgroundImage.image = controller.model.item.image
        
        let baseBlur:UIView = UIView()
        baseBlur.isUserInteractionEnabled = false
        baseBlur.translatesAutoresizingMaskIntoConstraints = false
        baseBlur.clipsToBounds = true
        baseBlur.alpha = kBlurAlpha
        
        let blur:VBlur = VBlur.light()
        
        let viewThumb:VSourceVideoTimeBarThumb = VSourceVideoTimeBarThumb(
            controller:controller)
        viewThumb.layer.cornerRadius = kThumbSize / 2.0
        
        let viewInfo:VSourceVideoTimeBarInfo = VSourceVideoTimeBarInfo(
            controller:controller)
        
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
        
        baseBlur.addSubview(blur)
        addSubview(backgroundImage)
        addSubview(baseBlur)
        addSubview(border)
        addSubview(viewThumb)
        addSubview(viewInfo)
        addSubview(buttonClose)
        
        NSLayoutConstraint.equals(
            view:backgroundImage,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:baseBlur,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:baseBlur)
        
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:viewThumb,
            toView:self,
            constant:kThumbTop)
        layoutThumbLeft = NSLayoutConstraint.leftToLeft(
            view:viewThumb,
            toView:self)
        NSLayoutConstraint.size(
            view:viewThumb,
            constant:kThumbSize)
        
        NSLayoutConstraint.bottomToBottom(
            view:viewInfo,
            toView:self)
        NSLayoutConstraint.height(
            view:viewInfo,
            constant:kInfoHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewInfo,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:buttonClose,
            toView:self)
        NSLayoutConstraint.height(
            view:buttonClose,
            constant:kCloseHeight)
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
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.width
        let remainWidth:CGFloat = width - kThumbSize
        let marginLeft:CGFloat = remainWidth / 2.0
        layoutThumbLeft.constant = marginLeft
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionClose(sender button:UIButton)
    {
        controller.close()
    }
}
