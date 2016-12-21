import UIKit

class VHomeControlCameraTickerFrames:UIView
{
    private weak var controller:CHome!
    private weak var buttonAdd:UIButton!
    private weak var buttonRest:UIButton!
    private weak var label:UILabel!
    private weak var layoutAddTop:NSLayoutConstraint!
    private weak var layoutRestBottom:NSLayoutConstraint!
    private let kButtonsHeight:CGFloat = 50
    private let kButtonsWidth:CGFloat = 60
    
    convenience init(controller:CHome)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        
        let buttonAdd:UIButton = UIButton()
        buttonAdd.translatesAutoresizingMaskIntoConstraints = false
        buttonAdd.setImage(
            #imageLiteral(resourceName: "assetHomeCameraFramesAdd").withRenderingMode(
                UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonAdd.setImage(
            #imageLiteral(resourceName: "assetHomeCameraFramesAdd").withRenderingMode(
                UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonAdd.imageView!.contentMode = UIViewContentMode.center
        buttonAdd.imageView!.clipsToBounds = true
        buttonAdd.imageView!.tintColor = UIColor(white:1, alpha:0.2)
        
        let buttonRest:UIButton = UIButton()
        buttonRest.translatesAutoresizingMaskIntoConstraints = false
        buttonRest.setImage(
            #imageLiteral(resourceName: "assetHomeCameraFramesRest").withRenderingMode(
                UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonRest.setImage(
            #imageLiteral(resourceName: "assetHomeCameraFramesRest").withRenderingMode(
                UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonRest.imageView!.contentMode = UIViewContentMode.center
        buttonRest.imageView!.clipsToBounds = true
        buttonRest.imageView!.tintColor = UIColor(white:1, alpha:0.2)
        
        addSubview(buttonAdd)
        addSubview(buttonRest)
        
        layoutAddTop = NSLayoutConstraint.topToTop(
            view:buttonAdd,
            toView:self)
        let layoutAddHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:buttonAdd,
            constant:kButtonsHeight)
        let layoutAddRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:buttonAdd,
            toView:self)
        let layoutAddWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:buttonAdd,
            constant:kButtonsWidth)
        
        addConstraints([
            layoutAddTop,
            layoutAddHeight,
            layoutAddRight,
            layoutAddWidth])
    }
}
