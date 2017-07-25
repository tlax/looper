import UIKit

class VSourceVideoImportProgress:
    View<VSourceVideoImport, MSourceVideoImport, CSourceVideoImport>
{
    private weak var layoutImageLeft:NSLayoutConstraint!
    private weak var layoutImageTop:NSLayoutConstraint!
    private let kImageSize:CGFloat = 128
    private let kBorderWidth:CGFloat = 1
    
    required init(controller:CSourceVideoImport)
    {
        super.init(controller:controller)
        isUserInteractionEnabled = false
     
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.image = controller.model.item.image
        imageView.layer.cornerRadius = kImageSize / 2.0
        imageView.layer.borderColor = UIColor(white:0, alpha:0.5).cgColor
        imageView.layer.borderWidth = kBorderWidth
        
        addSubview(imageView)
        
        layoutImageTop = NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self)
        layoutImageLeft = NSLayoutConstraint.leftToLeft(
            view:imageView,
            toView:self)
        NSLayoutConstraint.size(
            view:imageView,
            constant:kImageSize)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.width
        let height:CGFloat = bounds.height
        let remainWidth:CGFloat = width - kImageSize
        let remainHeight:CGFloat = height - kImageSize
        let marginLeft:CGFloat = remainWidth / 2.0
        let marginTop:CGFloat = remainHeight / 2.0
        layoutImageTop.constant = marginTop
        layoutImageLeft.constant = marginLeft
        
        super.layoutSubviews()
    }
    
    //MARK: public
    
    func updateProgress(percent:CGFloat)
    {
    }
}
