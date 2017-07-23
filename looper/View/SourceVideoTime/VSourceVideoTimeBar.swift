import UIKit

class VSourceVideoTimeBar:
View<VSourceVideoTime, MSourceVideoTime, CSourceVideoTime>
{
    private weak var layoutThumbTop:NSLayoutConstraint!
    private weak var layoutThumbLeft:NSLayoutConstraint!
    private let kThumbSize:CGFloat = 128
    
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
        
        let blur:VBlur = VBlur.light()
        
        let viewThumb:VSourceVideoTimeBarThumb = VSourceVideoTimeBarThumb(
            controller:controller)
        viewThumb.layer.cornerRadius = kThumbSize / 2.0
        
        addSubview(backgroundImage)
        addSubview(blur)
        addSubview(viewThumb)
        
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
}
