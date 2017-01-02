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
    
    //MARK: collectionView delegate
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        return 0
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
