import UIKit

class VHomeControl:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var viewCamera:VHomeControlCamera?
    private weak var controller:CHome!
    private weak var collectionView:UICollectionView!
    let kCollectionHeight:CGFloat = 64
    private let model:MHomeControl
    private let kDeselectTime:TimeInterval = 0.4
    
    init(controller:CHome)
    {
        model = MHomeControl()
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.genericDark
        self.controller = controller
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 0
        flow.sectionInset = UIEdgeInsets.zero
        
        let collectionView:UICollectionView = UICollectionView(
            frame:CGRect.zero,
            collectionViewLayout:flow)
        collectionView.clipsToBounds = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            VHomeControlCell.self,
            forCellWithReuseIdentifier:
            VHomeControlCell.reusableIdentifier)
        self.collectionView = collectionView
        
        let border:UIView = UIView()
        border.isUserInteractionEnabled = false
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = UIColor(
            white:1,
            alpha:0.2)
        
        addSubview(collectionView)
        addSubview(border)
        
        let layoutCollectionHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:collectionView,
            constant:kCollectionHeight)
        let layoutCollectionBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:collectionView,
            toView:self)
        let layoutCollectionLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:collectionView,
            toView:self)
        let layoutCollectionRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:collectionView,
            toView:self)
        
        let layoutBorderHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:border,
            constant:1)
        let layoutBorderBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        let layoutBorderLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:border,
            toView:self)
        let layoutBorderRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:border,
            toView:self)
        
        addConstraints([
            layoutCollectionHeight,
            layoutCollectionBottom,
            layoutCollectionLeft,
            layoutCollectionRight,
            layoutBorderHeight,
            layoutBorderBottom,
            layoutBorderLeft,
            layoutBorderRight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MHomeControlItem
    {
        let item:MHomeControlItem = model.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func showCamera()
    {
        let viewCamera:VHomeControlCamera = VHomeControlCamera(controller:controller)
        self.viewCamera = viewCamera
        addSubview(viewCamera)
        
        let layoutCameraTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:viewCamera,
            toView:self)
        let layoutCameraBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToTop(
            view:viewCamera,
            toView:collectionView)
        let layoutCameraLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewCamera,
            toView:self)
        let layoutCameraRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:viewCamera,
            toView:self)
        
        addConstraints([
            layoutCameraTop,
            layoutCameraBottom,
            layoutCameraLeft,
            layoutCameraRight])
        
        layoutIfNeeded()
    }
    
    func hideCamera()
    {
        viewCamera?.removeFromSuperview()
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let width:CGFloat = collectionView.bounds.maxX
        let height:CGFloat = collectionView.bounds.maxY
        let items:CGFloat = CGFloat(model.items.count)
        let widthPerCell:CGFloat = width / items
        let size:CGSize = CGSize(width:widthPerCell, height:height)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = model.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MHomeControlItem = modelAtIndex(index:indexPath)
        let cell:VHomeControlCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:VHomeControlCell.reusableIdentifier,
            for:indexPath) as! VHomeControlCell
        cell.config(
            model:item,
            controller:controller)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        let item:MHomeControlItem = modelAtIndex(index:indexPath)
        item.selected(controller:controller)
        
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kDeselectTime)
        { [weak collectionView] in
            
            collectionView?.selectItem(
                at:nil,
                animated:true,
                scrollPosition:UICollectionViewScrollPosition())
        }
    }
}
