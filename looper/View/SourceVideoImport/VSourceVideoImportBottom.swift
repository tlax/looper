import UIKit

class VSourceVideoImportBottom:
    View<VSourceVideoImport, MSourceVideoImport, CSourceVideoImport>
{
    private weak var layoutCancelLeft:NSLayoutConstraint!
    private let kCancelWidth:CGFloat = 140
    private let kCancelHeight:CGFloat = 40
    private let kCancelBottom:CGFloat = -20
    private let kTitleHeight:CGFloat = 25
    private let kSubtitleHeight:CGFloat = 30
    private let kSubtitleBottom:CGFloat = -90
    
    required init(controller:CSourceVideoImport)
    {
        super.init(controller:controller)
        
        let buttonCancel:UIButton = UIButton()
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        buttonCancel.setTitle(
            String.localizedView(key:"VSourceVideoImportBottom_buttonCancel"),
            for:UIControlState.normal)
        buttonCancel.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        buttonCancel.setTitleColor(
            UIColor(white:1, alpha:0.2),
            for:UIControlState.highlighted)
        buttonCancel.titleLabel!.font = UIFont.medium(size:15)
        buttonCancel.addTarget(
            self,
            action:#selector(actionCancel(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let labelTitle:UILabel = UILabel()
        labelTitle.isUserInteractionEnabled = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = UIColor.clear
        labelTitle.font = UIFont.medium(size:17)
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.textColor = UIColor.white
        labelTitle.text = String.localizedView(
            key:"VSourceVideoImportBottom_labelTitle")
        
        let labelSubtitle:UILabel = UILabel()
        labelSubtitle.isUserInteractionEnabled = false
        labelSubtitle.translatesAutoresizingMaskIntoConstraints = false
        labelSubtitle.backgroundColor = UIColor.clear
        labelSubtitle.font = UIFont.regular(size:14)
        labelSubtitle.textAlignment = NSTextAlignment.center
        labelSubtitle.textColor = UIColor(white:1, alpha:0.8)
        labelSubtitle.text = String.localizedView(
            key:"VSourceVideoImportBottom_labelSubtitle")
        
        addSubview(labelTitle)
        addSubview(labelSubtitle)
        addSubview(buttonCancel)
        
        NSLayoutConstraint.bottomToBottom(
            view:buttonCancel,
            toView:self,
            constant:kCancelBottom)
        NSLayoutConstraint.height(
            view:buttonCancel,
            constant:kCancelHeight)
        layoutCancelLeft = NSLayoutConstraint.leftToLeft(
            view:buttonCancel,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonCancel,
            constant:kCancelWidth)
        
        NSLayoutConstraint.bottomToTop(
            view:labelSubtitle,
            toView:buttonCancel,
            constant:kSubtitleBottom)
        NSLayoutConstraint.height(
            view:labelSubtitle,
            constant:kSubtitleHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelSubtitle,
            toView:self)
        
        NSLayoutConstraint.bottomToTop(
            view:labelTitle,
            toView:labelSubtitle)
        NSLayoutConstraint.height(
            view:labelTitle,
            constant:kTitleHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:labelTitle,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.width
        let remainCancel:CGFloat = width - kCancelWidth
        let marginCancel:CGFloat = remainCancel / 2.0
        layoutCancelLeft.constant = marginCancel
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionCancel(sender button:UIButton)
    {
        controller.cancel()
    }
}
