import UIKit

class VCollection
    <T:ViewMain, S:Model, R:Controller<T, S>, Q:UICollectionViewCell>:
    View<T, S, R>,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
{
    private(set) weak var collectionView:UICollectionView!
    private let kDeselectTime:TimeInterval = 0.3
    
    required init(controller:R)
    {
        super.init(controller:controller)
        
        let flow:VCollectionFlow = VCollectionFlow()
        
        let collectionView:UICollectionView = UICollectionView(
            frame:CGRect.zero,
            collectionViewLayout:flow)
        collectionView.clipsToBounds = true
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView = collectionView
        
        addSubview(collectionView)
        
        NSLayoutConstraint.equals(
            view:collectionView,
            toView:self)
        
        registerCell(cell:Q.self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    final func registerCell(cell:Q.Type)
    {
        collectionView.register(
            cell,
            forCellWithReuseIdentifier:cell.reusableIdentifier)
    }
    
    final func registerFooter(footer:UICollectionReusableView.Type)
    {
        collectionView.register(
            footer,
            forSupplementaryViewOfKind:UICollectionElementKindSectionFooter,
            withReuseIdentifier:footer.reusableIdentifier)
    }
    
    final func registerHeader(header:UICollectionReusableView.Type)
    {
        collectionView.register(
            header,
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader,
            withReuseIdentifier:header.reusableIdentifier)
    }
    
    final func cellAtIndex(indexPath:IndexPath) -> Q
    {
        let cell:Q = cellAtIndex(
            reusableIdentifier:Q.reusableIdentifier,
            indexPath:indexPath)
        
        return cell
    }
    
    final func cellAtIndex(reusableIdentifier:String, indexPath:IndexPath) -> Q
    {
        let cell:Q = collectionView.dequeueReusableCell(
            withReuseIdentifier:reusableIdentifier,
            for:indexPath) as! Q
        
        return cell
    }
    
    final func reusableAtIndex<P:UICollectionReusableView>(
        kind:String,
        type:P.Type,
        indexPath:IndexPath) -> P
    {
        let reusable:P = collectionView.dequeueReusableSupplementaryView(
            ofKind:kind,
            withReuseIdentifier:P.reusableIdentifier,
            for:indexPath) as! P
        
        return reusable
    }
    
    //MARK: collectionView delegate
    
    func scrollViewWillBeginDragging(_ scrollView:UIScrollView)
    {
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView:UIScrollView)
    {
    }
    
    func scrollViewDidScroll(_ scrollView:UIScrollView)
    {
    }
    
    func collectionView(
        _ collectionView:UICollectionView,
        layout collectionViewLayout:UICollectionViewLayout,
        insetForSectionAt section:Int) -> UIEdgeInsets
    {
        guard
        
            let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
        
        else
        {
            return UIEdgeInsets.zero
        }
        
        return flow.sectionInset
    }
    
    func collectionView(
        _ collectionView:UICollectionView,
        layout collectionViewLayout:UICollectionViewLayout,
        sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        guard
            
            let flow:VCollectionFlow = collectionView.collectionViewLayout as? VCollectionFlow
            
        else
        {
            return CGSize.zero
        }
        
        return flow.itemSize
    }
    
    func numberOfSections(
        in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(
        _ collectionView:UICollectionView,
        numberOfItemsInSection section:Int) -> Int
    {
        return 0
    }
    
    func collectionView(
        _ collectionView:UICollectionView,
        viewForSupplementaryElementOfKind kind:String,
        at indexPath:IndexPath) -> UICollectionReusableView
    {
        let reusable:UICollectionReusableView = reusableAtIndex(
            kind:kind,
            type:UICollectionReusableView.self,
            indexPath:indexPath)
        
        return reusable
    }
    
    func collectionView(
        _ collectionView:UICollectionView,
        cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let cell:Q = cellAtIndex(
            reusableIdentifier:Q.reusableIdentifier,
            indexPath:indexPath)
        
        return cell
    }
    
    func collectionView(
        _ collectionView:UICollectionView,
        shouldSelectItemAt indexPath:IndexPath) -> Bool
    {
        return true
    }
    
    func collectionView(
        _ collectionView:UICollectionView,
        shouldHighlightItemAt indexPath:IndexPath) -> Bool
    {
        return true
    }
    
    func collectionView(
        _ collectionView:UICollectionView,
        didSelectItemAt indexPath:IndexPath)
    {
        collectionView.isUserInteractionEnabled = false
        
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kDeselectTime)
        { [weak collectionView] in
            
            collectionView?.isUserInteractionEnabled = true
            collectionView?.selectItem(
                at:nil,
                animated:true,
                scrollPosition:UICollectionViewScrollPosition())
        }
    }
}
