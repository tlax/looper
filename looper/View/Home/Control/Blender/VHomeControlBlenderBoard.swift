import UIKit

class VHomeControlBlenderBoard:UIView
{
    private weak var viewMain:VHomeControlBlenderBoardMain!
    private let kMarginTop:CGFloat = 120
    private let kMarginLeft:CGFloat = 10
    private let kMainSize:CGFloat = 110
    private let kLabelMainWidth:CGFloat = 150
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        
        let viewMain:VHomeControlBlenderBoardMain = VHomeControlBlenderBoardMain()
        self.viewMain = viewMain
        
        let labelsColor:UIColor = UIColor(white:1, alpha:0.5)
        
        let labelMain:UILabel = UILabel()
        labelMain.isUserInteractionEnabled = false
        labelMain.translatesAutoresizingMaskIntoConstraints = false
        labelMain.font = UIFont.bold(size:17)
        labelMain.textColor = labelsColor
        labelMain.backgroundColor = UIColor.clear
        labelMain.text = NSLocalizedString(
            "VHomeControlBlenderBoard_labelMain", comment:"")
        
        addSubview(labelMain)
        addSubview(viewMain)
        
        viewMain.layoutTop = NSLayoutConstraint.topToTop(
            view:viewMain,
            toView:self,
            constant:kMarginTop)
        viewMain.layoutLeft = NSLayoutConstraint.leftToLeft(
            view:viewMain,
            toView:self,
            constant:kMarginLeft)
        viewMain.layoutWidth = NSLayoutConstraint.width(
            view:viewMain,
            constant:kMainSize)
        viewMain.layoutHeight = NSLayoutConstraint.height(
            view:viewMain,
            constant:kMainSize)
        
        let layoutLabelTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:labelMain,
            toView:viewMain)
        let layoutLabelBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:labelMain,
            toView:viewMain)
        let layoutLabelLeft:NSLayoutConstraint = NSLayoutConstraint.leftToRight(
            view:labelMain,
            toView:viewMain,
            constant:kMarginLeft)
        let layoutLabelWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:labelMain,
            constant:kLabelMainWidth)
        
        addConstraints([
            viewMain.layoutTop,
            viewMain.layoutLeft,
            viewMain.layoutWidth,
            viewMain.layoutHeight,
            layoutLabelTop,
            layoutLabelBottom,
            layoutLabelLeft,
            layoutLabelWidth])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
