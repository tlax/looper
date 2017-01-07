import UIKit

class VHelp:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CHelp!
    private weak var collectionView:VCollection!
    private weak var pageControl:UIPageControl!
    private weak var layoutButtonLeft:NSLayoutConstraint!
    private let kControlBottom:CGFloat = -30
    private let kControlHeight:CGFloat = 50
    private let kButtonWidth:CGFloat = 120
    private let kButtonHeight:CGFloat = 34
    private let kButtonBottom:CGFloat = -20
    private let kCornerRadius:CGFloat = 17
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CHelp
        
        let blurEffect:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.extraLight)
        let visualEffect:UIVisualEffectView = UIVisualEffectView(
            effect:blurEffect)
        visualEffect.isUserInteractionEnabled = false
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        visualEffect.clipsToBounds = true
        
        let button:UIButton = UIButton()
        button.backgroundColor = UIColor.genericLight
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setTitle(
            NSLocalizedString("VHelp_button", comment:""),
            for:UIControlState.normal)
        button.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        button.setTitleColor(
            UIColor(white:1, alpha:0.2),
            for:UIControlState.highlighted)
        button.titleLabel!.font = UIFont.bold(size:16)
        button.layer.cornerRadius = kCornerRadius
        button.addTarget(
            self,
            action:#selector(actionButton(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let collectionView:VCollection = VCollection()
        collectionView.flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        collectionView.alwaysBounceHorizontal = true
        collectionView.isPagingEnabled = true
        collectionView.registerCell(cell:VHelpCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView = collectionView
        
        let pageControl:UIPageControl = UIPageControl()
        pageControl.isUserInteractionEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.clipsToBounds = true
        pageControl.numberOfPages = self.controller.model.items.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = UIColor.genericLight
        pageControl.pageIndicatorTintColor = UIColor(white:0, alpha:0.1)
        self.pageControl = pageControl
        
        addSubview(visualEffect)
        addSubview(collectionView)
        addSubview(pageControl)
        addSubview(button)
        
        let constraintsEffect:[NSLayoutConstraint] = NSLayoutConstraint.equals(
            view:visualEffect,
            parent:self)
        
        let constraintsCollection:[NSLayoutConstraint] = NSLayoutConstraint.equals(
            view:collectionView,
            parent:self)
        
        let layoutButtonBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:button,
            toView:self,
            constant:kButtonBottom)
        let layoutButtonHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:button,
            constant:kButtonHeight)
        layoutButtonLeft = NSLayoutConstraint.leftToLeft(
            view:button,
            toView:self)
        let layoutButtonWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:button,
            constant:kButtonWidth)
        
        let layoutControlBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToTop(
            view:pageControl,
            toView:button,
            constant:kControlBottom)
        let layoutControlHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:pageControl,
            constant:kControlHeight)
        let layoutControlLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:pageControl,
            toView:self)
        let layoutControlRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:pageControl,
            toView:self)
        
        addConstraints(constraintsEffect)
        addConstraints(constraintsCollection)
        
        addConstraints([
            layoutButtonBottom,
            layoutButtonHeight,
            layoutButtonLeft,
            layoutButtonWidth,
            layoutControlBottom,
            layoutControlHeight,
            layoutControlLeft,
            layoutControlRight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remain:CGFloat = width - kButtonWidth
        let margin:CGFloat = remain / 2.0
        layoutButtonLeft.constant = margin
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionButton(sender button:UIButton)
    {
        controller.back()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MHelpItem
    {
        let item:MHelpItem = controller.model.items[index.item]
        
        return item
    }
    
    //MARK: collectionView delegate
    
    func scrollViewDidScroll(_ scrollView:UIScrollView)
    {
        let midX:CGFloat = scrollView.bounds.midX
        let midY:CGFloat = scrollView.bounds.midY
        let offsetX:CGFloat = scrollView.contentOffset.x
        let centerX:CGFloat = midX + offsetX
        let pointCenter:CGPoint = CGPoint(
            x:centerX,
            y:midY)
        
        guard
        
            let indexPath:IndexPath = collectionView.indexPathForItem(
                at:pointCenter)
        
        else
        {
            return
        }
        
        let indexItem:Int = indexPath.item
        pageControl.currentPage = indexItem
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let width:CGFloat = collectionView.bounds.maxX
        let height:CGFloat = collectionView.bounds.maxY
        let size:CGSize = CGSize(width:width, height:height)
        
        return size
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
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
        let item:MHelpItem = modelAtIndex(index:indexPath)
        let cell:VHelpCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VHelpCell.reusableIdentifier,
            for:indexPath) as! VHelpCell
        cell.config(model:item)
        
        return cell
    }
}
