import UIKit

class VCameraScaleSliderTrack:UIView
{
    private weak var selectedView:VBorder!
    private weak var layoutSelectedHeight:NSLayoutConstraint!
    var totalTrack:CGFloat
    
    init()
    {
        totalTrack = 0
        
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
        layoutSelectedHeight = NSLayoutConstraint.height(
            view:selectedView)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        layer.cornerRadius = width / 2.0
        totalTrack = bounds.maxY
        
        super.layoutSubviews()
    }
    
    //MARK: public
    
    func trackSelected(percent:CGFloat)
    {
        let height:CGFloat = percent * totalTrack
        layoutSelectedHeight.constant = height
    }
}
