import UIKit

class VSourceVideo:
    ViewMain,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
{
    private weak var spinner:VSpinner!
    private weak var collectionView:VCollection!
    private weak var layoutBarHeight:NSLayoutConstraint!
    private var cellSize:CGSize?
    private let kBarMinHeight:CGFloat = 64
    private let kCollectionMargin:CGFloat = 1
    private let kCollectionBottom:CGFloat = 20
    private let kCellsPerRow:CGFloat = 3
    private let kAnimationDuration:TimeInterval = 0.3
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
        
        let collectionView:VCollection = VCollection()
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VSourceVideoCell.self)

        if let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        {
            let topMargin:CGFloat = kBarMinHeight + kCollectionMargin
            
            flow.sectionInset = UIEdgeInsets(
                top:topMargin,
                left:kCollectionMargin,
                bottom:kCollectionBottom,
                right:kCollectionMargin)
        }
        
        self.collectionView = collectionView
        
        addSubview(spinner)
        addSubview(collectionView)
        addSubview(viewBar)
        
        NSLayoutConstraint.equals(
            view:spinner,
            toView:self)
        
        NSLayoutConstraint.equals(
            view:collectionView,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        layoutBarHeight = NSLayoutConstraint.height(
            view:viewBar,
            constant:kBarMinHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
    }
    
    private func modelAtIndex(index:IndexPath) -> MSourceVideoItem
    {
        let controller:CSourceVideo = self.controller as! CSourceVideo
        let item:MSourceVideoItem = controller.model.items[index.item]
        
        return item
    }
    
    private func animateBar()
    {
        let height:CGFloat = bounds.height
        layoutBarHeight.constant = height
        
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.layoutIfNeeded()
        }
    }
    
    //MARK: public
    
    func refresh()
    {
        spinner.stopAnimating()
        collectionView.reloadData()
    }
    
    func loading(item:MSourceVideoItem)
    {
        collectionView.isHidden = true
        spinner.startAnimating()
        animateBar()
    }
    
    //MARK: collectionView delegate
    
    func collectionView(
        _ collectionView:UICollectionView,
        layout collectionViewLayout:UICollectionViewLayout,
        sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        guard
        
            let cellSize:CGSize = self.cellSize
        
        else
        {
            let width:CGFloat = collectionView.bounds.width
            let subtractWidth:CGFloat = kCellsPerRow * kCollectionMargin
            let usableWidth:CGFloat = width - subtractWidth
            let cellWidth:CGFloat = usableWidth / kCellsPerRow
            let cellSize:CGSize = CGSize(width:cellWidth, height:cellWidth)
            self.cellSize = cellSize
            
            return cellSize
        }
        
        return cellSize
    }
    
    func numberOfSections(
        in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(
        _ collectionView:UICollectionView,
        numberOfItemsInSection section:Int) -> Int
    {
        let controller:CSourceVideo = self.controller as! CSourceVideo
        let count:Int = controller.model.items.count
        
        return count
    }
    
    func collectionView(
        _ collectionView:UICollectionView,
        cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MSourceVideoItem = modelAtIndex(index:indexPath)
        let cell:VSourceVideoCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VSourceVideoCell.reusableIdentifier,
            for:indexPath) as! VSourceVideoCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(
        _ collectionView:UICollectionView,
        didSelectItemAt indexPath:IndexPath)
    {
        collectionView.isUserInteractionEnabled = false
        
        let item:MSourceVideoItem = modelAtIndex(index:indexPath)
        
        let controller:CSourceVideo = self.controller as! CSourceVideo
        controller.selected(item:item)
    }
}
