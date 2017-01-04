import UIKit

class VLoopsCell:UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private let modelOptions:MLoopsOptions
    private weak var model:MLoopsItem?
    private weak var collectionView:VCollection!
    private weak var imageView:UIImageView!
    private let kBackgroundMargin:CGFloat = 1
    private let kDeselect:TimeInterval = 0.3
    
    override init(frame:CGRect)
    {
        modelOptions = MLoopsOptions()
        
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let countOptions:CGFloat = CGFloat(modelOptions.items.count)
        let width:CGFloat = frame.size.width
        let height:CGFloat = frame.size.height
        let backgroundHeight:CGFloat = width + kBackgroundMargin + kBackgroundMargin
        let collectionHeight:CGFloat = height - backgroundHeight
        let cellsWidth:CGFloat = collectionHeight * countOptions
        let marginRight:CGFloat = width - cellsWidth
        
        let button:UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        
        let collectionView:VCollection = VCollection()
        collectionView.flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        collectionView.flow.itemSize = CGSize(
            width:collectionHeight,
            height:collectionHeight)
        collectionView.flow.sectionInset = UIEdgeInsets(
            top:0,
            left:0,
            bottom:0,
            right:marginRight)
        collectionView.isScrollEnabled = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(
            cell:VLoopsCellOption.self)
        self.collectionView = collectionView
        
        let background:UIView = UIView()
        background.clipsToBounds = true
        background.translatesAutoresizingMaskIntoConstraints = false
        background.isUserInteractionEnabled = false
        background.backgroundColor = UIColor.black
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView = imageView
        
        addSubview(background)
        addSubview(imageView)
        addSubview(button)
        addSubview(collectionView)
        
        let layoutImageTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:imageView,
            toView:background,
            constant:kBackgroundMargin)
        let layoutImageBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:imageView,
            toView:background,
            constant:-kBackgroundMargin)
        let layoutImageLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:imageView,
            toView:background)
        let layoutImageRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:imageView,
            toView:background)
        
        let layoutBackgroundTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:background,
            toView:self)
        let layoutBackgroundHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:background,
            constant:backgroundHeight)
        let layoutBackgroundLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:background,
            toView:self)
        let layoutBackgroundRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:background,
            toView:self)
        
        let layoutCollectionTop:NSLayoutConstraint = NSLayoutConstraint.topToBottom(
            view:collectionView,
            toView:background)
        let layoutCollectionBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:collectionView,
            toView:self)
        let layoutCollectionLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:collectionView,
            toView:self)
        let layoutCollectionRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:collectionView,
            toView:self)
        
        addConstraints([
            layoutImageTop,
            layoutImageBottom,
            layoutImageLeft,
            layoutImageRight,
            layoutBackgroundTop,
            layoutBackgroundHeight,
            layoutBackgroundLeft,
            layoutBackgroundRight,
            layoutCollectionTop,
            layoutCollectionBottom,
            layoutCollectionLeft,
            layoutCollectionRight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MLoopsOptionsItem
    {
        let item:MLoopsOptionsItem = modelOptions.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func config(model:MLoopsItem)
    {
        self.model = model
        imageView.image = model.images.first
        imageView.animationDuration = model.duration
        imageView.animationImages = model.images
    }
    
    //MARK: collectionView delegate
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = modelOptions.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MLoopsOptionsItem = modelAtIndex(index:indexPath)
        let cell:VLoopsCellOption = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VLoopsCellOption.reusableIdentifier,
            for:indexPath) as! VLoopsCellOption
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kDeselect)
        { [weak collectionView] in
            
            collectionView?.selectItem(
                at:nil,
                animated:true,
                scrollPosition:UICollectionViewScrollPosition())
        }
    }
}
