import UIKit

class VHomeControlBlenderPieces:UIView
{
    private weak var controller:CHome!
    private let kItemSize:CGFloat = 70
    private let itemSize_2:CGFloat
    
    init(controller:CHome)
    {
        itemSize_2 = kItemSize / 2.0
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        self.controller = controller
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
