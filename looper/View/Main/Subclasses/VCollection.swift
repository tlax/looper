import UIKit

class VCollection:UICollectionView
{
    weak var flow:UICollectionViewFlowLayout!
    
    init()
    {
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        self.flow = flow
        
        super.init(frame:CGRect.zero, collectionViewLayout:flow)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func registerCell(cell:UICollectionViewCell.Type)
    {
        register(
            cell,
            forCellWithReuseIdentifier:cell.reusableIdentifier)
    }
    
    func registerReusable(reusable:UICollectionReusableView.Type, kind:String)
    {
        register(
            reusable,
            forSupplementaryViewOfKind:kind,
            withReuseIdentifier:reusable.reusableIdentifier)
    }
}
