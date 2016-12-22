import UIKit

class VHomeControlBlenderBoard:UIView
{
    private weak var viewMain:VHomeControlBlenderBoardMain!
    private let kMarginTop:CGFloat = 120
    private let kMarginLeft:CGFloat = 10
    private let kMainSize:CGFloat = 110
    private let kLabelMainWidth:CGFloat = 150
    private let kLabelBoardHeight:CGFloat = 30
    private let kLabelBoardTop:CGFloat = 40
    
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
        let labelsFont:UIFont = UIFont.bold(size:17)
        
        let labelMain:UILabel = UILabel()
        labelMain.isUserInteractionEnabled = false
        labelMain.translatesAutoresizingMaskIntoConstraints = false
        labelMain.font = labelsFont
        labelMain.textColor = labelsColor
        labelMain.backgroundColor = UIColor.clear
        labelMain.text = NSLocalizedString(
            "VHomeControlBlenderBoard_labelMain", comment:"")
        
        let labelBoard:UILabel = UILabel()
        labelBoard.isUserInteractionEnabled = false
        labelBoard.translatesAutoresizingMaskIntoConstraints = false
        labelBoard.font = labelsFont
        labelBoard.textColor = labelsColor
        labelBoard.backgroundColor = UIColor.clear
        labelBoard.textAlignment = NSTextAlignment.center
        labelBoard.text = NSLocalizedString(
            "VHomeControlBlenderBoard_labelBoard", comment:"")
        
        addSubview(labelMain)
        addSubview(labelBoard)
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
        
        let layoutLabelMainTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:labelMain,
            toView:viewMain)
        let layoutLabelMainBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:labelMain,
            toView:viewMain)
        let layoutLabelMainLeft:NSLayoutConstraint = NSLayoutConstraint.leftToRight(
            view:labelMain,
            toView:viewMain,
            constant:kMarginLeft)
        let layoutLabelMainWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:labelMain,
            constant:kLabelMainWidth)
        
        let layoutLabelBoardHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:labelBoard,
            constant:kLabelBoardHeight)
        let layoutLabelBoardTop:NSLayoutConstraint = NSLayoutConstraint.topToBottom(
            view:labelBoard,
            toView:viewMain,
            constant:kLabelBoardTop)
        let layoutLabelBoardLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:labelBoard,
            toView:self)
        let layoutLabelBoardRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:labelBoard,
            toView:self)
        
        addConstraints([
            viewMain.layoutTop,
            viewMain.layoutLeft,
            viewMain.layoutWidth,
            viewMain.layoutHeight,
            layoutLabelMainTop,
            layoutLabelMainBottom,
            layoutLabelMainLeft,
            layoutLabelMainWidth,
            layoutLabelBoardTop,
            layoutLabelBoardHeight,
            layoutLabelBoardLeft,
            layoutLabelBoardRight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
