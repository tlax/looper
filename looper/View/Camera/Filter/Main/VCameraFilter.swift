import UIKit

class VCameraFilter:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var viewBar:VCameraFilterBar!
    private weak var controller:CCameraFilter!
    private weak var collectionView:VCollection!
    private let kBarHeight:CGFloat = 64
    private let kCollectionTop:CGFloat = 64
    private let kCollectionBottom:CGFloat = 20
    private let kAfterSelect:TimeInterval = 0.2
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CCameraFilter
        
        let viewBar:VCameraFilterBar = VCameraFilterBar(
            controller:self.controller)
        self.viewBar = viewBar
        
        let collectionView:VCollection = VCollection()
        collectionView.flow.sectionInset = UIEdgeInsets(
            top:kCollectionTop,
            left:0,
            bottom:kCollectionBottom,
            right:0)
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VCameraFilterCell.self)
        self.collectionView = collectionView
        
        addSubview(collectionView)
        addSubview(viewBar)
        
        NSLayoutConstraint.equalsHorizontal(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        NSLayoutConstraint.height(
            view:viewBar,
            constant:kBarHeight)
        
        NSLayoutConstraint.equals(
            view:collectionView,
            toView:self)
        
        var indexSelected:Int?
        let countItems:Int = self.controller.modelFilter.items.count
        
        for indexItem:Int in 0 ..< countItems
        {
            let item:MCameraFilterItem = self.controller.modelFilter.items[indexItem]
            
            if item === self.controller.modelFilter.currentFilter
            {
                indexSelected = indexItem
                
                break
            }
        }
        
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kAfterSelect)
        { [weak self] in
            
            guard
            
                let index:Int = indexSelected
            
            else
            {
                return
            }
            
            let indexPath:IndexPath = IndexPath(item:index, section:0)
            self?.collectionView.selectItem(
                at:indexPath,
                animated:false,
                scrollPosition:UICollectionViewScrollPosition.top)
        }
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MCameraFilterItem
    {
        let item:MCameraFilterItem = controller.modelFilter.items[index.item]
        
        return item
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width:CGFloat = collectionView.bounds.maxX
        let side:CGFloat = width / 2.0
        let size:CGSize = CGSize(width:side, height:side)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.modelFilter.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MCameraFilterItem = modelAtIndex(index:indexPath)
        let cell:VCameraFilterCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VCameraFilterCell.reusableIdentifier,
            for:indexPath) as! VCameraFilterCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        let item:MCameraFilterItem = modelAtIndex(index:indexPath)
        controller.modelFilter.currentFilter = item
    }
}
