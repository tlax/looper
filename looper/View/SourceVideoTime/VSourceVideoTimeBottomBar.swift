import UIKit

class VSourceVideoTimeBottomBar:
    View<VSourceVideoTime, MSourceVideoTime, CSourceVideoTime>
{
    private weak var layoutImportLeft:NSLayoutConstraint!
    private let kBorderHeight:CGFloat = 1
    private let kImportWidth:CGFloat = 140
    
    required init(controller:CSourceVideoTime)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.colourSuccess
        
        let border:VBorder = VBorder(
            colour:UIColor.black)
        
        let buttonImport:UIButton = UIButton()
        buttonImport.translatesAutoresizingMaskIntoConstraints = false
        buttonImport.setTitle(
            String.localizedView(key:"VSourceVideoTimeBottomBar_buttonImport"),
            for:UIControlState.normal)
        buttonImport.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        buttonImport.setTitleColor(
            UIColor(white:1, alpha:0.2),
            for:UIControlState.highlighted)
        buttonImport.titleLabel!.font = UIFont.bold(size:17)
        
        addSubview(border)
        addSubview(buttonImport)
        
        NSLayoutConstraint.topToTop(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:kBorderHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
        
        NSLayoutConstraint.equalsVertical(
            view:buttonImport,
            toView:self)
        layoutImportLeft = NSLayoutConstraint.leftToLeft(
            view:buttonImport,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonImport,
            constant:kImportWidth)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.width
        let remainImport:CGFloat = width - kImportWidth
        let marginImport:CGFloat = remainImport / 2.0
        layoutImportLeft.constant = marginImport
        
        super.layoutSubviews()
    }
}
