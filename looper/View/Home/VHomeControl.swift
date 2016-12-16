import UIKit

class VHomeControl:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CHome!
    private weak var collectionView:UICollectionView!
    
    convenience init(controller:CHome)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        self.controller = controller
    }
    
    //MARK: collectionView delegate
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
}
