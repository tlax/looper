import UIKit

class VSourceVideo:ViewMain
{
    static let kBarHeight:CGFloat = 64
    
    private weak var spinner:VSpinner!
    private weak var viewList:VSourceVideoList!
    private let kPanBack:Bool = true
    
    required init(controller:UIViewController)
    {
        super.init(controller:controller)
        
        guard
        
            let controller:CSourceVideo = controller as? CSourceVideo
        
        else
        {
            return
        }
        
        factoryViews(controller:controller)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    deinit
    {
        spinner.stopAnimating()
    }
    
    override var panBack:Bool
    {
        get
        {
            return kPanBack
        }
    }
    
    //MARK: private
    
    private func factoryViews(controller:CSourceVideo)
    {
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        let viewBar:VSourceVideoBar = VSourceVideoBar(controller:controller)

        let viewList:VSourceVideoList = VSourceVideoList(controller:controller)
        self.viewList = viewList
        
        addSubview(spinner)
        addSubview(viewList)
        addSubview(viewBar)
        
        NSLayoutConstraint.equals(
            view:spinner,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:viewList,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBar,
            constant:VSourceVideo.kBarHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
    }
    
    //MARK: public
    
    func refresh()
    {
        spinner.stopAnimating()
        viewList.collectionView.reloadData()
    }
}
