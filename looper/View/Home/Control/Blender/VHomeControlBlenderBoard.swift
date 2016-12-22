import UIKit

class VHomeControlBlenderBoard:UIView
{
    private weak var viewMain:VHomeControlBlenderBoardMain!
    private weak var viewOver:VHomeControlBlenderBoardOver!
    private let kMarginTop:CGFloat = 130
    private let kMarginLeft:CGFloat = 10
    private let kMainSize:CGFloat = 90
    private let kOverSize:CGFloat = 170
    private let kLabelMainWidth:CGFloat = 150
    private let kLabelBoardHeight:CGFloat = 30
    private let kLabelBoardTop:CGFloat = 30
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        
        let viewMain:VHomeControlBlenderBoardMain = VHomeControlBlenderBoardMain()
        self.viewMain = viewMain
        
        let viewOver:VHomeControlBlenderBoardOver = VHomeControlBlenderBoardOver()
        self.viewOver = viewOver
        
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
        addSubview(viewOver)
        
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
        
        viewOver.layoutTop = NSLayoutConstraint.topToBottom(
            view:viewOver,
            toView:labelBoard)
        viewOver.layoutLeft = NSLayoutConstraint.leftToLeft(
            view:viewOver,
            toView:self)
        viewOver.layoutWidth = NSLayoutConstraint.width(
            view:viewOver,
            constant:kOverSize)
        viewOver.layoutHeight = NSLayoutConstraint.height(
            view:viewOver,
            constant:kOverSize)
        
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
            viewOver.layoutTop,
            viewOver.layoutLeft,
            viewOver.layoutWidth,
            viewOver.layoutHeight,
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
    
    override func layoutSubviews()
    {
        let totalWidth:CGFloat = bounds.maxX
        let remainWidth:CGFloat = totalWidth - kOverSize
        let marginLeft:CGFloat = remainWidth / 2.0
        viewOver.layoutLeft.constant = marginLeft
        
        super.layoutSubviews()
    }
    
    //MARK: public
    
    func 
}
