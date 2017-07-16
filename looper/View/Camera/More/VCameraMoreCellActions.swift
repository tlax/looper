import UIKit

class VCameraMoreCellActions:VCameraMoreCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var modelActions:MCameraMoreItemActions?
    private weak var collectionView:VCollection!
    private let kCellWidth:CGFloat = 62
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let height:CGFloat = frame.size.height
        let collectionView:VCollection = VCollection()
        collectionView.flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        collectionView.flow.minimumLineSpacing = 0
        collectionView.flow.minimumInteritemSpacing = 0
        collectionView.flow.itemSize = CGSize(
            width:kCellWidth,
            height:height)
        collectionView.flow.sectionInset = UIEdgeInsets.zero
        collectionView.isScrollEnabled = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VCameraMoreCellActionsOption.self)
        self.collectionView = collectionView
        
        addSubview(collectionView)
        
        NSLayoutConstraint.equals(
            view:collectionView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func config(controller:CCameraMore, model:MCameraMoreItem)
    {
        super.config(controller:controller, model:model)
        modelActions = model as? MCameraMoreItemActions
        collectionView.reloadData()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MCameraMoreItemActionsOption
    {
        let item:MCameraMoreItemActionsOption = modelActions!.options[index.item]
        
        return item
    }
    
    //MARK: collectionView delegate
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        let count:Int
        
        if modelActions == nil
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
        let count:Int = modelActions!.options.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MCameraMoreItemActionsOption = modelAtIndex(index:indexPath)
        let cell:VCameraMoreCellActionsOption = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VCameraMoreCellActionsOption.reusableIdentifier,
            for:indexPath) as! VCameraMoreCellActionsOption
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        let item:MCameraMoreItemActionsOption = modelAtIndex(index:indexPath)
        
        controller?.viewMore.close
        { [weak controller] in
            
            item.selected(controller:controller)
        }
    }
}
