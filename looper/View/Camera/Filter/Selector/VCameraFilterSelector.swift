import UIKit

class VCameraFilterSelector:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CCameraFilterSelector!
    private weak var collectionView:VCollection!
    private weak var spinner:VSpinner!
    private weak var backButton:UIButton!
    private weak var nextButton:UIButton!
    private weak var title:UILabel!
    private var trackScroll:Bool
    private let kContentTop:CGFloat = 20
    private let kButtonsWidth:CGFloat = 55
    private let kButtonsHeight:CGFloat = 44
    private let kAlphaActive:CGFloat = 1
    private let kAlphaNotActive:CGFloat = 0.2
    
    override init(controller:CController)
    {
        trackScroll = true
        
        super.init(controller:controller)
        self.controller = controller as? CCameraFilterSelector
        
        let backButton:UIButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        backButton.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        backButton.imageView!.contentMode = UIViewContentMode.center
        backButton.imageView!.clipsToBounds = true
        backButton.imageView!.tintColor = UIColor(white:0, alpha:0.2)
        backButton.addTarget(
            self,
            action:#selector(actionBack(sender:)),
            for:UIControlEvents.touchUpInside)
        self.backButton = backButton
        
        let nextButton:UIButton = UIButton()
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setImage(
            #imageLiteral(resourceName: "assetGenericNext").withRenderingMode(
                UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        nextButton.setImage(
            #imageLiteral(resourceName: "assetGenericNext").withRenderingMode(
                UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        nextButton.imageView!.contentMode = UIViewContentMode.center
        nextButton.imageView!.tintColor = UIColor(white:0, alpha:0.2)
        nextButton.imageView!.clipsToBounds = true
        nextButton.addTarget(
            self,
            action:#selector(actionNext(sender:)),
            for:UIControlEvents.touchUpInside)
        self.nextButton = nextButton
        
        let title:UILabel = UILabel()
        title.isUserInteractionEnabled = false
        title.translatesAutoresizingMaskIntoConstraints = false
        title.backgroundColor = UIColor.clear
        title.font = UIFont.bold(size:16)
        title.textAlignment = NSTextAlignment.center
        title.textColor = UIColor.black
        title.text = self.controller.filter.viewTitle
        self.title = title
        
        let collectionView:VCollection = VCollection()
        collectionView.flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        collectionView.alwaysBounceHorizontal = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VCameraFilterSelectorCellRecord.self)
        collectionView.registerCell(cell:VCameraFilterSelectorCellColor.self)
        self.collectionView = collectionView
        
        let spinner:VSpinner = VSpinner()
        spinner.stopAnimating()
        self.spinner = spinner
        
        addSubview(title)
        addSubview(collectionView)
        addSubview(spinner)
        addSubview(backButton)
        addSubview(nextButton)
        
        NSLayoutConstraint.equals(
            view:collectionView,
            toView:self)
        NSLayoutConstraint.equals(
            view:spinner,
            toView:self)
        
        NSLayoutConstraint.topToTop(
            view:backButton,
            toView:self,
            constant:kContentTop)
        NSLayoutConstraint.height(
            view:backButton,
            constant:kButtonsHeight)
        NSLayoutConstraint.leftToLeft(
            view:backButton,
            toView:self)
        NSLayoutConstraint.width(
            view:backButton,
            constant:kButtonsWidth)
        
        NSLayoutConstraint.topToTop(
            view:nextButton,
            toView:self,
            constant:kContentTop)
        NSLayoutConstraint.height(
            view:nextButton,
            constant:kButtonsHeight)
        NSLayoutConstraint.rightToRight(
            view:nextButton,
            toView:self)
        NSLayoutConstraint.width(
            view:nextButton,
            constant:kButtonsWidth)
        
        NSLayoutConstraint.topToTop(
            view:title,
            toView:self,
            constant:kContentTop)
        NSLayoutConstraint.height(
            view:title,
            constant:kButtonsHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:title,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionBack(sender button:UIButton)
    {
        controller.back()
    }
    
    func actionNext(sender button:UIButton)
    {
        controller.next()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MCameraFilterSelectorItem
    {
        let item:MCameraFilterSelectorItem = controller.model.items[index.item]
        
        return item
    }
    
    private func stopLoading()
    {
        spinner.stopAnimating()
        collectionView.isHidden = false
        backButton.alpha = kAlphaActive
        nextButton.alpha = kAlphaActive
        title.alpha = kAlphaActive
        backButton.isUserInteractionEnabled = true
        nextButton.isUserInteractionEnabled = true
    }
    
    //MARK: public
    
    func selectCurrent()
    {
        let indexPath:IndexPath = IndexPath(
            item:controller.model.selected,
            section:0)
        
        collectionView.selectItem(
            at:indexPath,
            animated:false,
            scrollPosition:UICollectionViewScrollPosition.centeredHorizontally)
        
        stopLoading()
    }
    
    func startLoading()
    {
        spinner.startAnimating()
        collectionView.isHidden = true
        backButton.alpha = kAlphaNotActive
        nextButton.alpha = kAlphaNotActive
        title.alpha = kAlphaNotActive
        backButton.isUserInteractionEnabled = false
        nextButton.isUserInteractionEnabled = false
    }
    
    //MARK: collectionView delegate
    
    func scrollViewDidScroll(_ scrollView:UIScrollView)
    {
        if trackScroll
        {
            let offsetX:CGFloat = scrollView.contentOffset.x
            let midX:CGFloat = scrollView.bounds.size.width / 2.0
            let midY:CGFloat = scrollView.bounds.size.height / 2.0
            let totalX:CGFloat = midX + offsetX
            let point:CGPoint = CGPoint(x:totalX, y:midY)
            
            guard
                
                let indexPath:IndexPath = collectionView.indexPathForItem(at:point)
                
            else
            {
                return
            }
            
            controller.model.selected = indexPath.item
            collectionView.selectItem(
                at:indexPath,
                animated:true,
                scrollPosition:UICollectionViewScrollPosition())
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView:UIScrollView)
    {
        trackScroll = true
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView:UIScrollView)
    {
        trackScroll = true
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let item:MCameraFilterSelectorItem = modelAtIndex(index:indexPath)
        let height:CGFloat = collectionView.bounds.maxY
        let size:CGSize = CGSize(width:item.cellWidth, height:height)
        
        return size
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, insetForSectionAt section:Int) -> UIEdgeInsets
    {
        let width:CGFloat = collectionView.bounds.maxX
        let width_2:CGFloat = width / 2.0
        let firstCellWidth:CGFloat = controller.model.items.first!.cellWidth
        let lastCellWidth:CGFloat = controller.model.items.last!.cellWidth
        let firstCellWidth_2:CGFloat = firstCellWidth / 2.0
        let lastCellWidth_2:CGFloat = lastCellWidth / 2.0
        let leftMargin:CGFloat = width_2 - firstCellWidth_2
        let rightMargin:CGFloat = width_2 - lastCellWidth_2
        let insets:UIEdgeInsets = UIEdgeInsets(
            top:0,
            left:leftMargin,
            bottom:0,
            right:rightMargin)
        
        return insets
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MCameraFilterSelectorItem = modelAtIndex(index:indexPath)
        let cell:VCameraFilterSelectorCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            item.reusableIdentifier,
            for:indexPath) as! VCameraFilterSelectorCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        trackScroll = false
        controller.model.selected = indexPath.item
        
        collectionView.scrollToItem(
            at:indexPath,
            at:UICollectionViewScrollPosition.centeredHorizontally,
            animated:true)
    }
}
