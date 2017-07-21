import UIKit

class VSpinner:UIImageView
{
    private let kAnimationDuration:TimeInterval = 1
    
    init()
    {
        super.init(frame:CGRect.zero)
        
        let images:[UIImage] = [
            #imageLiteral(resourceName: "assetSpinner00"),
            #imageLiteral(resourceName: "assetSpinner01"),
            #imageLiteral(resourceName: "assetSpinner02"),
            #imageLiteral(resourceName: "assetSpinner03"),
            #imageLiteral(resourceName: "assetSpinner04"),
            #imageLiteral(resourceName: "assetSpinner05"),
            #imageLiteral(resourceName: "assetSpinner06"),
            #imageLiteral(resourceName: "assetSpinner07"),
            #imageLiteral(resourceName: "assetSpinner08"),
            #imageLiteral(resourceName: "assetSpinner09"),
            #imageLiteral(resourceName: "assetSpinner10"),
            #imageLiteral(resourceName: "assetSpinner11"),
            #imageLiteral(resourceName: "assetSpinner12"),
            #imageLiteral(resourceName: "assetSpinner13"),
            #imageLiteral(resourceName: "assetSpinner14"),
            #imageLiteral(resourceName: "assetSpinner15"),
            #imageLiteral(resourceName: "assetSpinner16"),
            #imageLiteral(resourceName: "assetSpinner17")]
        
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
        return nil
    }
}
