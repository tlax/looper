import UIKit

class VCameraHeader:UICollectionReusableView
{
    private weak var controller:CCamera?
    private weak var buttonShoot:VCameraHeaderButton!
    private weak var buttonProcess:VCameraHeaderButton!
    private weak var buttonFilter:VCameraHeaderButton!
    private let kButtonsTop:CGFloat = 75
    private let kButtonsWidth:CGFloat = 65
    private let kShootRight:CGFloat = 10
 
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let buttonShoot:VCameraHeaderButton = VCameraHeaderButton(
            image:#imageLiteral(resourceName: "assetCameraShoot"))
        self.buttonShoot = buttonShoot
        
        addSubview(buttonShoot)
        
        let layoutShootTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:buttonShoot,
            toView:self,
            constant:kButtonsTop)
        let layoutShootBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:buttonShoot,
            toView:self)
        let layoutShootRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:buttonShoot,
            toView:self,
            constant:kShootRight)
        let layoutShootWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:buttonShoot,
            constant:kButtonsWidth)
        
        addConstraints([
            layoutShootTop,
            layoutShootBottom,
            layoutShootRight,
            layoutShootWidth])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func config(controller:CCamera)
    {
        self.controller = controller
    }
}
