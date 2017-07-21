import UIKit

class VSourceVideoBar:View<VSourceVideo, MSourceVideo, CSourceVideo>
{
    required init(controller:CSourceVideo)
    {
        super.init(controller:controller)
        
        let colourTop:UIColor = UIColor(
            red:0.9137254901960784,
            green:0.38823529411764707,
            blue:0.09019607843137255,
            alpha:1)
        let colourBottom:UIColor = UIColor(
            red:1,
            green:0.5921568627450979,
            blue:0.36078431372549025,
            alpha:1)
        
        let viewGradient:VGradient = VGradient.vertical(
            colourTop:colourTop,
            colourBottom:colourBottom)
        
        addSubview(viewGradient)
        
        NSLayoutConstraint.equals(
            view:viewGradient,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
