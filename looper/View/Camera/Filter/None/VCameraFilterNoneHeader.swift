import UIKit

class VCameraFilterNoneHeader:UICollectionReusableView
{
    weak var controller:CCameraFilterNone?
    private let kLabelMarginHorizontal:CGFloat = 40
    private let kContentTop:CGFloat = 20
    private let kBackWidth:CGFloat = 55
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.medium(size:16)
        label.textColor = UIColor.black
        label.text = NSLocalizedString("VCameraFilterNoneHeader_label", comment:"")
        
        let backButton:UIButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        backButton.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        backButton.imageView!.contentMode = UIViewContentMode.center
        backButton.imageView!.clipsToBounds = true
        backButton.imageView!.tintColor = UIColor(white:0, alpha:0.2)
        backButton.addTarget(
            self,
            action:#selector(actionBack(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(label)
        addSubview(backButton)
        
        NSLayoutConstraint.equalsHorizontal(
            view:label,
            toView:self,
            margin:kLabelMarginHorizontal)
        
        NSLayoutConstraint.topToTop(
            view:label,
            toView:self,
            constant:kContentTop)
        NSLayoutConstraint.bottomToBottom(
            view:label,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:backButton,
            toView:self,
            constant:kContentTop)
        NSLayoutConstraint.bottomToBottom(
            view:backButton,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:backButton,
            toView:self)
        NSLayoutConstraint.width(
            view:backButton,
            constant:kBackWidth)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: actions
    
    func actionBack(sender button:UIButton)
    {
        controller?.back()
    }
}
