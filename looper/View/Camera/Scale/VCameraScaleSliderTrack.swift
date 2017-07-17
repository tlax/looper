import UIKit

class VCameraScaleSliderTrack:UIView
{
    weak var selectedView:VBorder!
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(white:0, alpha:0.1)
        
        let selectedView:VBorder = VBorder(color:UIColor.genericLight)
        self.selectedView = selectedView
        
        addSubview(selectedView)
        
        NSLayoutConstraint.equalsHorizontal(
            view:selectedView,
            toView:self)
        NSLayoutConstraint.bottomToBottom(
            view:selectedView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
}
