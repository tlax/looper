import UIKit

class VHomeTimeline:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CHome!
    private weak var collectionView:UICollectionView!
    private weak var model:MHomeImageSequenceGenerated?
    private let kInterline:CGFloat = 1
    private let kCellSize:CGFloat = 74
    
    convenience init(controller:CHome)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.genericDark
        self.controller = controller
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.minimumLineSpacing = kInterline
        flow.minimumInteritemSpacing = kInterline
        flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        flow.sectionInset = UIEdgeInsets(
            top:0,
            left:kInterline,
            bottom:0,
            right:kInterline)
        
        let collectionView:UICollectionView = UICollectionView(
            frame:CGRect.zero,
            collectionViewLayout:flow)
        collectionView.clipsToBounds = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            VHomeTimelineCell.self,
            forCellWithReuseIdentifier:
            VHomeTimelineCell.reusableIdentifier)
        self.collectionView = collectionView
        
        addSubview(collectionView)
        
        let layoutCollectionTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:collectionView,
            toView:self)
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
            layoutCollectionTop,
            layoutCollectionBottom,
            layoutCollectionLeft,
            layoutCollectionRight])
        
        model = controller.modelImage.generateSequence()
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(self.notifiedImagesUpdated(sender:)),
            name:Notification.imagesUpdated,
            object:nil)
    }
    
    //MARK: notifications
    
    func notifiedImagesUpdated(sender notification:Notification)
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.refresh()
        }
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MHomeImageSequenceItem
    {
        let item:MHomeImageSequenceItem = model!.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func refresh()
    {
        model = controller.modelImage.generateSequence()
        collectionView.reloadData()
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let height:CGFloat = collectionView.bounds.maxY
        let size:CGSize = CGSize(
            width:kCellSize,
            height:height)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        let count:Int
        
        if model == nil
        {
            count = 0
        }
        else
        {
            count = 1
        }
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = model!.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MHomeImageSequenceItem = modelAtIndex(index:indexPath)
        let cell:VHomeTimelineCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VHomeTimelineCell.reusableIdentifier,
            for:indexPath) as! VHomeTimelineCell
        cell.config(model:item)
        
        return cell
    }
}
