import UIKit

class VEditCropImage:View<VEditCrop, MEditCrop, CEditCrop>
{
    private weak var layoutImageLeft:NSLayoutConstraint!
    private weak var layoutImageRight:NSLayoutConstraint!
    private weak var layoutImageTop:NSLayoutConstraint!
    private weak var layoutImageBottom:NSLayoutConstraint!
    private weak var viewCornerTopLeft:VEditCropImageCornerTopLeft!
    private var image:UIImage?
    private let imageMargin2:CGFloat
    private let kImageMargin:CGFloat = 20
    private let kImageBorderWidth:CGFloat = 1
    private let kCornerSize:CGFloat = 35
    
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
        imageView.layer.borderColor = UIColor(white:1, alpha:0.5).cgColor
        
        let viewCornerTopLeft:VEditCropImageCornerTopLeft = VEditCropImageCornerTopLeft()
        self.viewCornerTopLeft = viewCornerTopLeft
        
        addSubview(imageView)
        addSubview(viewCornerTopLeft)
        
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
        
        viewCornerTopLeft.layoutTop = NSLayoutConstraint.topToTop(
            view:viewCornerTopLeft,
            toView:self)
        viewCornerTopLeft.layoutLeft = NSLayoutConstraint.leftToLeft(
            view:viewCornerTopLeft,
            toView:self)
        NSLayoutConstraint.size(
            view:viewCornerTopLeft,
            constant:kCornerSize)
        
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
        
        let canvasWidth:CGFloat = bounds.width
        let canvasHeight:CGFloat = bounds.height
        let usableWidth:CGFloat = canvasWidth - imageMargin2
        let usableHeight:CGFloat = canvasHeight - imageMargin2
        let width:CGFloat = image.size.width
        let height:CGFloat = image.size.height
        let deltaWidth:CGFloat = width / usableWidth
        let deltaHeight:CGFloat = height / usableHeight
        let maxDelta:CGFloat = max(deltaWidth, deltaHeight)
        let ratioWidth:CGFloat = width / maxDelta
        let ratioHeight:CGFloat = height / maxDelta
        let remainWidth:CGFloat = canvasWidth - ratioWidth
        let remainHeight:CGFloat = canvasHeight - ratioHeight
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
