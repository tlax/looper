import UIKit

class VCameraMoreCellActions:VCameraMoreCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var modelActions:MCameraMoreItemActions?
    private weak var collectionView:VCollection!
    private let kInterline:CGFloat = 1
    private let kCellWidth:CGFloat = 65
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        
        let height:CGFloat = frame.size.height
        let collectionView:VCollection = VCollection()
        collectionView.flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        collectionView.flow.minimumLineSpacing = kInterline
        collectionView.flow.minimumInteritemSpacing = kInterline
        collectionView.flow.itemSize = CGSize(
            width:kCellWidth,
            height:height)
        collectionView.flow.sectionInset = UIEdgeInsets(
            top:0,
            left:kInterline,
            bottom:0,
            right:0)
        collectionView.isScrollEnabled = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VCameraMoreCellActionsOption.self)
        self.collectionView = collectionView
        
        addSubview(collectionView)
        
        let constraintsCollection:[NSLayoutConstraint] = NSLayoutConstraint.equals(
            view:collectionView,
            toView:self)
        
        addConstraints(constraintsCollection)
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
}
