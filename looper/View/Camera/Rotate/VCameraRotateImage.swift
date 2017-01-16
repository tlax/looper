import UIKit

class VCameraRotateImage:UIView
{
    private weak var controller:CCameraRotate!
    private weak var imageView:UIImageView!
    private weak var border:VBorder!
    private weak var layoutBorderTop:NSLayoutConstraint!
    private weak var layoutBorderLeft:NSLayoutConstraint!
    private weak var layoutBorderBottom:NSLayoutConstraint!
    private weak var layoutBorderRight:NSLayoutConstraint!
    private var borderMargin:CGFloat
    private let kImageMargin:CGFloat = 120
    private let kImageBorder:CGFloat = 2
    
    init(controller:CCameraRotate)
    {
        borderMargin = (kImageMargin - kImageBorder) * 2
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let border:VBorder = VBorder(color:UIColor.black)
        self.border = border
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.image = controller.record.items.first?.image
        self.imageView = imageView

        addSubview(border)
        addSubview(imageView)
        
        NSLayoutConstraint.equals(
            view:imageView,
            toView:self,
            margin:kImageMargin)
        
        layoutBorderTop = NSLayoutConstraint.topToTop(
            view:border,
            toView:self)
        layoutBorderBottom = NSLayoutConstraint.bottomToTop(
            view:border,
            toView:self)
        layoutBorderLeft = NSLayoutConstraint.leftToLeft(
            view:border,
            toView:self)
        layoutBorderRight = NSLayoutConstraint.rightToRight(
            view:border,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let height:CGFloat = bounds.maxY
        let hrMargin:CGFloat
        let vrMargin:CGFloat
        
        if width <= height
        {
            let deltaHeightWidth:CGFloat = height - width
            let deltaHeightWidth_2:CGFloat = deltaHeightWidth / 2.0
            
            hrMargin = width - borderMargin
            vrMargin = hrMargin + deltaHeightWidth_2
        }
        else
        {
            let deltaWidthHeight:CGFloat = width - height
            let deltaWidthHeight_2:CGFloat = deltaWidthHeight / 2.0
            
            vrMargin = height - borderMargin
            hrMargin = vrMargin + deltaWidthHeight_2
        }
        
        layoutBorderTop.constant = vrMargin
        layoutBorderBottom.constant = -vrMargin
        layoutBorderLeft.constant = hrMargin
        layoutBorderRight.constant = -hrMargin
        
        super.layoutSubviews()
    }
}
