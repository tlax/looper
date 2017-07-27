import UIKit

class VEditCropImage:View<VEditCrop, MEditCrop, CEditCrop>
{
    weak var movingCorner:VEditCropImageCorner?
    weak var cornerTopLeft:VEditCropImageCornerTopLeft!
    weak var layoutImageLeft:NSLayoutConstraint!
    weak var layoutImageRight:NSLayoutConstraint!
    weak var layoutImageTop:NSLayoutConstraint!
    weak var layoutImageBottom:NSLayoutConstraint!
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
    
    override func touchesBegan(
        _ touches:Set<UITouch>,
        with event:UIEvent?)
    {
        touchesBegan(touches:touches)
    }
    
    override func touchesMoved(
        _ touches:Set<UITouch>,
        with event:UIEvent?)
    {
        touchesMoved(touches:touches)
    }
    
    override func touchesCancelled(
        _ touches:Set<UITouch>,
        with event:UIEvent?)
    {
        touchesCancelled(touches:touches)
    }
    
    override func touchesEnded(
        _ touches:Set<UITouch>,
        with event:UIEvent?)
    {
        touchesEnded(touches:touches)
    }
}
