import UIKit

class VSpinner:UIImageView
{
    private let kAnimationDuration:TimeInterval = 1
    
    init()
    {
        super.init(frame:CGRect.zero)
        
        let images:[UIImage] = [
            #imageLiteral(resourceName: "assetSpinner0"),
            #imageLiteral(resourceName: "assetSpinner1"),
            #imageLiteral(resourceName: "assetSpinner2"),
            #imageLiteral(resourceName: "assetSpinner3"),
            #imageLiteral(resourceName: "assetSpinner4"),
            #imageLiteral(resourceName: "assetSpinner5"),
            #imageLiteral(resourceName: "assetSpinner6"),
            #imageLiteral(resourceName: "assetSpinner7")
        ]
        
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        animationDuration = kAnimationDuration
        animationImages = images
        contentMode = UIViewContentMode.center
        startAnimating()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
