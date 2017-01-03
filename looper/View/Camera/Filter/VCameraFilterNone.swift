import UIKit

class VCameraFilterNone:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CCameraFilterNone!
    private weak var collectionView:VCollection!
    private let kHeaderHeight:CGFloat = 110
    private let kCollectionBottom:CGFloat = 20
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CCameraFilterNone
        
        let collectionView:VCollection = VCollection()
        collectionView.flow.headerReferenceSize = CGSize(
            width:0,
            height:kHeaderHeight)
        collectionView.flow.sectionInset = UIEdgeInsets(
            top:0,
            left:0,
            bottom:kCollectionBottom,
            right:0)
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
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let cell:VCameraFilterNoneCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VCameraFilterNoneCell.reusableIdentifier,
            for:indexPath) as! VCameraFilterNoneCell
        
        return cell
    }
}
