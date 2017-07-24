import UIKit

class VHomeMenu:View<VHome, MHome, CHome>
{
    private weak var layoutNewTop:NSLayoutConstraint!
    private weak var layoutNewLeft:NSLayoutConstraint!
    private let kNewSize:CGFloat = 65
    private let kBorderHeight:CGFloat = 1
    private let kBorderTop:CGFloat = 60
    
    required init(controller:CHome)
    {
        super.init(controller:controller)
        
        let border:VBorder = VBorder(colour:UIColor.colourBackgroundGray)
        
        let viewNew:VHomeMenuNew = VHomeMenuNew(controller:controller)
        
        addSubview(border)
        addSubview(viewNew)
        
        NSLayoutConstraint.topToTop(
            view:border,
            toView:self,
            constant:kBorderTop)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
        
        layoutNewTop = NSLayoutConstraint.topToTop(
            view:viewNew,
            toView:self)
        layoutNewLeft = NSLayoutConstraint.leftToLeft(
            view:viewNew,
            toView:self)
        NSLayoutConstraint.size(
            view:viewNew,
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
