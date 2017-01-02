import UIKit

class VCameraFilterNone:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CCameraFilterNone!
    private weak var collectionView:VCollection!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CCameraFilterNone
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
