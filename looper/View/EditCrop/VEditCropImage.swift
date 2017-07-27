import UIKit

class VEditCropImage:View<VEditCrop, MEditCrop, CEditCrop>
{
    weak var layoutImageLeft:NSLayoutConstraint!
    weak var layoutImageRight:NSLayoutConstraint!
    weak var layoutImageTop:NSLayoutConstraint!
    weak var layoutImageBottom:NSLayoutConstraint!
    weak var viewCornerTopLeft:VEditCropImageCornerTopLeft!
    var image:UIImage?
    let imageMargin2:CGFloat
    let kImageMargin:CGFloat = 20
    let kImageBorderWidth:CGFloat = 1
    let kCornerSize:CGFloat = 35
    
    required init(controller:CEditCrop)
    {
        imageMargin2 = kImageMargin + kImageMargin
        
        super.init(controller:controller)
        backgroundColor = UIColor.black
        
        factoryViews()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        print("layout")
        constraintImage()
        
        super.layoutSubviews()
    }
}
