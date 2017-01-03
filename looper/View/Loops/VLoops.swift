import UIKit

class VLoops:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CLoops!
    private weak var collectionView:VCollection!
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CLoops
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: collectionView delegate
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        
    }
}
