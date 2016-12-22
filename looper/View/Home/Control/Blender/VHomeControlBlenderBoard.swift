import UIKit

class VHomeControlBlenderBoard:UIView
{
    private weak var viewMain:VHomeControlBlenderBoardMain!
    private let kMarginTop:CGFloat = 100
    private let kMarginLeft:CGFloat = 10
    private let kMainSize:CGFloat = 110
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        
        let viewMain:VHomeControlBlenderBoardMain = VHomeControlBlenderBoardMain()
        self.viewMain = viewMain
        
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
        
        addConstraints([
            viewMain.layoutTop,
            viewMain.layoutLeft,
            viewMain.layoutWidth,
            viewMain.layoutHeight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
