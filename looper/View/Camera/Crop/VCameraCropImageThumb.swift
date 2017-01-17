import UIKit

class VCameraCropImageThumb:UIImageView
{
    weak var layoutTop:NSLayoutConstraint!
    weak var layoutBottom:NSLayoutConstraint!
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = UIViewContentMode.center
        isUserInteractionEnabled = false
        
        state(selected:false)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func state(selected:Bool)
    {
        if selected
        {
            image = #imageLiteral(resourceName: "assetCameraScaleThumb")
        }
        else
        {
            image = #imageLiteral(resourceName: "assetCameraScaleThumb")
        }
    }
}
