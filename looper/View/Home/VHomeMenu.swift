import UIKit

class VHomeMenu:View<VHome, MHome, CHome>
{
    private weak var layoutNewTop:NSLayoutConstraint!
    private weak var layoutNewLeft:NSLayoutConstraint!
    private let kNewSize:CGFloat = 65
    
    required init(controller:CHome)
    {
        super.init(controller:controller)
        backgroundColor = UIColor(red:0.95, green:0.96, blue:0.97, alpha:1)
        
        let buttonNew:UIButton = UIButton()
        buttonNew.translatesAutoresizingMaskIntoConstraints = false
        buttonNew.setImage(
            #imageLiteral(resourceName: "assetGenericNewOff"),
            for:UIControlState.normal)
        buttonNew.setImage(
            #imageLiteral(resourceName: "assetGenericNewOn"),
            for:UIControlState.highlighted)
        buttonNew.imageView!.clipsToBounds = true
        buttonNew.imageView!.contentMode = UIViewContentMode.center
        
        addSubview(buttonNew)
        
        layoutNewTop = NSLayoutConstraint.topToTop(
            view:buttonNew,
            toView:self)
        layoutNewLeft = NSLayoutConstraint.leftToLeft(
            view:buttonNew,
            toView:self)
        NSLayoutConstraint.size(
            view:buttonNew,
            constant:kNewSize)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.width
        let height:CGFloat = bounds.height
        let sizeRemainWidth:CGFloat = width - kNewSize
        let sizeRemainHeight:CGFloat = height - kNewSize
        let sizeMarginLeft:CGFloat = sizeRemainWidth / 2.0
        let sizeMarginTop:CGFloat = sizeRemainHeight / 2.0
        layoutNewLeft.constant = sizeMarginLeft
        layoutNewTop.constant = sizeMarginTop
        
        super.layoutSubviews()
    }
}
