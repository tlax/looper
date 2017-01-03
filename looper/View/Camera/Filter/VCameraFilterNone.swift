import UIKit

class VCameraFilterNone:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var collectionView:VCollection!
    private weak var controller:CCameraFilterNone!
    private let kHeaderHeight:CGFloat = 67
    private let kCollectionTop:CGFloat = 20
    private let kCollectionBottom:CGFloat = 20
    private let kInterItem:CGFloat = 5
    private let interItem3:CGFloat
    
    override init(controller:CController)
    {
        interItem3 = kInterItem * 3
        
        super.init(controller:controller)
        self.controller = controller as? CCameraFilterNone
        
        let collectionView:VCollection = VCollection()
        collectionView.flow.headerReferenceSize = CGSize(
            width:0,
            height:kHeaderHeight)
        collectionView.flow.minimumInteritemSpacing = kInterItem
        collectionView.flow.minimumLineSpacing = kInterItem
        collectionView.flow.sectionInset = UIEdgeInsets(
            top:kCollectionTop,
            left:kInterItem,
            bottom:kCollectionBottom,
            right:kInterItem)
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VCameraFilterNoneCell.self)
        collectionView.registerHeader(header:VCameraFilterNoneHeader.self)
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
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MCameraRecord
    {
        let item:MCameraRecord = controller.model.activeRecords![index.item]
        
        return item
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let width:CGFloat = collectionView.bounds.maxX - interItem3
        let cellSize:CGFloat = width / 2.0
        let size:CGSize = CGSize(width:cellSize, height:cellSize)
        
        return size
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int
        
        if let records:[MCameraRecord] = controller.model.activeRecords
        {
            count = records.count
        }
        else
        {
            count = 0
        }
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, viewForSupplementaryElementOfKind kind:String, at indexPath:IndexPath) -> UICollectionReusableView
    {
        let header:VCameraFilterNoneHeader = collectionView.dequeueReusableSupplementaryView(
            ofKind:kind,
            withReuseIdentifier:
            VCameraFilterNoneHeader.reusableIdentifier,
            for:indexPath) as! VCameraFilterNoneHeader
        header.controller = controller
        
        return header
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MCameraRecord = modelAtIndex(index:indexPath)
        let cell:VCameraFilterNoneCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VCameraFilterNoneCell.reusableIdentifier,
            for:indexPath) as! VCameraFilterNoneCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        let item:MCameraRecord = modelAtIndex(index:indexPath)
        controller.selected(record:item)
    }
}
