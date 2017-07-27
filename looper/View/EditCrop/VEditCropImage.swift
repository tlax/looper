import UIKit

class VEditCropImage:View<VEditCrop, MEditCrop, CEditCrop>
{
    private weak var layoutImageLeft:NSLayoutConstraint!
    private weak var layoutImageRight:NSLayoutConstraint!
    private weak var layoutImageTop:NSLayoutConstraint!
    private weak var layoutImageBottom:NSLayoutConstraint!
    private var image:UIImage?
    private let imageMargin2:CGFloat
    private let kImageMargin:CGFloat = 30
    private let kImageBorderWidth:CGFloat = 1
    
    required init(controller:CEditCrop)
    {
        imageMargin2 = kImageMargin + kImageMargin
        
        super.init(controller:controller)
        backgroundColor = UIColor.black
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.layer.borderWidth = kImageBorderWidth
        imageView.layer.borderColor = UIColor(white:1, alpha:0.2).cgColor
        
        addSubview(imageView)
        
        layoutImageTop = NSLayoutConstraint.topToTop(
            view:imageView,
            toView:self)
        layoutImageBottom = NSLayoutConstraint.bottomToBottom(
            view:imageView,
            toView:self)
        layoutImageLeft = NSLayoutConstraint.leftToLeft(
            view:imageView,
            toView:self)
        layoutImageRight = NSLayoutConstraint.rightToRight(
            view:imageView,
            toView:self)
        
        guard
            
            let cgImage:CGImage = controller.model.edit.sequence?.items.first?.image
            
        else
        {
            return
        }
        
        image = UIImage(cgImage:cgImage)
        imageView.image = image
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: private
    
    private func constraintImage()
    {
        guard
        
            let image:UIImage = self.image
        
        else
        {
            return
        }
        
        let canvasSize:CGFloat = bounds.width
        let usableCanvas:CGFloat = canvasSize - imageMargin2
        let width:CGFloat = image.size.width
        let height:CGFloat = image.size.height
        let maxSize:CGFloat = max(width, height)
        let ratio:CGFloat = maxSize / usableCanvas
        let usableWidth:CGFloat = width / ratio
        let usableHeight:CGFloat = height / ratio
        let remainWidth:CGFloat = canvasSize - usableWidth
        let remainHeight:CGFloat = canvasSize - usableHeight
        let marginWidth:CGFloat = remainWidth / 2.0
        let marginHeight:CGFloat = remainHeight / 2.0
        
        layoutImageRight.constant = -marginWidth
        layoutImageLeft.constant = marginWidth
        layoutImageTop.constant = marginHeight
        layoutImageBottom.constant = -marginHeight
    }
    
    override func layoutSubviews()
    {
        print("layout")
        constraintImage()
        
        super.layoutSubviews()
    }
}
