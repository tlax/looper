import UIKit

class VSourceVideoTimeBar:
View<VSourceVideoTime, MSourceVideoTime, CSourceVideoTime>
{
    private weak var layoutThumbTop:NSLayoutConstraint!
    private weak var layoutThumbLeft:NSLayoutConstraint!
    private let kThumbSize:CGFloat = 128
    private let kCloseTop:CGFloat = 10
    private let kCloseWidth:CGFloat = 60
    private let kCloseHeight:CGFloat = 44
    private let kCloseEdgeRight:CGFloat = 20
    
    required init(controller:CSourceVideoTime)
    {
        super.init(controller:controller)
        
        let backgroundImage:UIImageView = UIImageView()
        backgroundImage.isUserInteractionEnabled = false
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.clipsToBounds = true
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        backgroundImage.image = controller.model.item.image
        
        let blur:VBlur = VBlur.light()
        
        let viewThumb:VSourceVideoTimeBarThumb = VSourceVideoTimeBarThumb(
            controller:controller)
        viewThumb.layer.cornerRadius = kThumbSize / 2.0
        
        let buttonClose:UIButton = UIButton()
        buttonClose.translatesAutoresizingMaskIntoConstraints = false
        buttonClose.setImage(
            #imageLiteral(resourceName: "assetGenericCloseNegative"),
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
        
        addSubview(backgroundImage)
        addSubview(blur)
        addSubview(viewThumb)
        addSubview(buttonClose)
        
        NSLayoutConstraint.equals(
            view:backgroundImage,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
        layoutThumbTop = NSLayoutConstraint.topToTop(
            view:viewThumb,
            toView:self)
        layoutThumbLeft = NSLayoutConstraint.leftToLeft(
            view:viewThumb,
            toView:self)
        NSLayoutConstraint.size(
            view:viewThumb,
            constant:kThumbSize)
        
        NSLayoutConstraint.topToTop(
            view:buttonClose,
            toView:self,
            constant:kCloseTop)
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
        let height:CGFloat = bounds.height
        let remainWidth:CGFloat = width - kThumbSize
        let remainHeight:CGFloat = height - kThumbSize
        let marginLeft:CGFloat = remainWidth / 2.0
        let marginTop:CGFloat = remainHeight / 2.0
        layoutThumbLeft.constant = marginLeft
        layoutThumbTop.constant = marginTop
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionClose(sender button:UIButton)
    {
        controller.close()
    }
}
