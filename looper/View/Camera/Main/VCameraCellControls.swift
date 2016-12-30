import UIKit

class VCameraCellControls:UIView
{
    private let kBorderWidth:CGFloat = 1
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        
        
        
        addConstraints([])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
