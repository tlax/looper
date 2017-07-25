import UIKit

class VSourceVideoTimeBar:
View<VSourceVideoTime, MSourceVideoTime, CSourceVideoTime>
{
    private weak var layoutThumbLeft:NSLayoutConstraint!
    private let kThumbTop:CGFloat = 60
    private let kThumbSize:CGFloat = 128
    private let kInfoHeight:CGFloat = 150
    private let kBlurAlpha:CGFloat = 0.8
    
    required init(controller:CSourceVideoTime)
    {
        super.init(controller:controller)
        isUserInteractionEnabled = false
        
        let backgroundImage:UIImageView = UIImageView()
        backgroundImage.isUserInteractionEnabled = false
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.clipsToBounds = true
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        backgroundImage.image = controller.model.item.image
        
        let baseBlur:UIView = UIView()
        baseBlur.isUserInteractionEnabled = false
        baseBlur.translatesAutoresizingMaskIntoConstraints = false
        baseBlur.clipsToBounds = true
        baseBlur.alpha = kBlurAlpha
        
        let blur:VBlur = VBlur.light()
        blur.backgroundColor = UIColor.black
        
        let viewThumb:VSourceVideoTimeBarThumb = VSourceVideoTimeBarThumb(
            controller:controller)
        viewThumb.layer.cornerRadius = kThumbSize / 2.0
        
        let viewInfo:VSourceVideoTimeBarInfo = VSourceVideoTimeBarInfo(
            controller:controller)
        
        baseBlur.addSubview(blur)
        addSubview(backgroundImage)
        addSubview(baseBlur)
        addSubview(viewThumb)
        addSubview(viewInfo)
        
        NSLayoutConstraint.equals(
            view:backgroundImage,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:baseBlur,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:baseBlur)
        
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
}
