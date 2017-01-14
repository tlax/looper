import UIKit

class VLoopsFooter:UICollectionReusableView
{
    private weak var controller:CLoops?
    private weak var button:UIButton!
    private weak var layoutButtonLeft:NSLayoutConstraint!
    private let kButtonSize:CGFloat = 80
    private let kButtonTop:CGFloat = 20
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let button:UIButton = UIButton()
        button.isUserInteractionEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(
            #imageLiteral(resourceName: "assetLoopsHelp").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        button.setImage(
            #imageLiteral(resourceName: "assetLoopsHelp").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        button.imageView!.tintColor = UIColor(white:0.97, alpha:1)
        button.imageView!.clipsToBounds = true
        button.imageView!.contentMode = UIViewContentMode.center
        button.addTarget(
            self,
            action:#selector(actionHelp(sender:)),
            for:UIControlEvents.touchUpInside)
        self.button = button
        
        addSubview(button)
        
        NSLayoutConstraint.topToTop(
            view:button,
            toView:self,
            constant:kButtonTop)
        NSLayoutConstraint.height(
            view:button,
            constant:kButtonSize)
        layoutButtonLeft = NSLayoutConstraint.leftToLeft(
            view:button,
            toView:self)
        NSLayoutConstraint.width(
            view:button,
            constant:kButtonSize)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remain:CGFloat = width - kButtonSize
        let margin:CGFloat = remain / 2.0
        layoutButtonLeft.constant = margin
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionHelp(sender button:UIButton)
    {
        button.isUserInteractionEnabled = false
        controller?.help()
    }
    
    //MARK: public
    
    func config(controller:CLoops)
    {
        self.controller = controller
        button.isUserInteractionEnabled = true
    }
}
