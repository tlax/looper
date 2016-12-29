import UIKit

class VCameraCell:UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var collectionView:VCollection!
    private weak var model:MCameraRecord?
    private let kCollectionMargin:CGFloat = 10
    private let kCollectionHeight:CGFloat = 70
    private let kCellSize:CGFloat = 63
    private let kInterLine:CGFloat = 1
    private let kBorderHeight:CGFloat = 1
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let collectionView:VCollection = VCollection()
        collectionView.flow.itemSize = CGSize(
            width:kCellSize,
            height:kCollectionHeight)
        collectionView.flow.minimumInteritemSpacing = kInterLine
        collectionView.flow.minimumLineSpacing = kInterLine
        collectionView.flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        collectionView.flow.sectionInset = UIEdgeInsets(
            top:0,
            left:kCollectionMargin,
            bottom:0,
            right:kCollectionMargin)
        collectionView.alwaysBounceHorizontal = true
        collectionView.registerCell(
            cell:VCameraCellItem.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        self.collectionView = collectionView
        
        let borderColor:UIColor = UIColor(white:0, alpha:0.1)
        
        let borderTop:UIView = UIView()
        borderTop.isUserInteractionEnabled = false
        borderTop.backgroundColor = borderColor
        borderTop.translatesAutoresizingMaskIntoConstraints = false
        borderTop.clipsToBounds = true
        
        let borderBottom:UIView = UIView()
        borderBottom.isUserInteractionEnabled = false
        borderBottom.backgroundColor = borderColor
        borderBottom.translatesAutoresizingMaskIntoConstraints = false
        borderBottom.clipsToBounds = true
        
        addSubview(borderTop)
        addSubview(borderBottom)
        addSubview(collectionView)
        
        let layoutCollectionTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:collectionView,
            toView:self,
            constant:kCollectionMargin)
        let layoutCollectionHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:collectionView,
            constant:kCollectionHeight)
        let layoutCollectionLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:collectionView,
            toView:self)
        let layoutCollectionRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:collectionView,
            toView:self)
        
        let layoutBorderTopTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:borderTop,
            toView:self)
        let layoutBorderTopHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:borderTop,
            constant:kBorderHeight)
        let layoutBorderTopLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:borderTop,
            toView:self)
        let layoutBorderTopRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:borderTop,
            toView:self)
        
        let layoutBorderBottomBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:borderBottom,
            toView:self)
        let layoutBorderBottomHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:borderBottom,
            constant:kBorderHeight)
        let layoutBorderBottomLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:borderBottom,
            toView:self)
        let layoutBorderBottomRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:borderBottom,
            toView:self)
        
        addConstraints([
            layoutCollectionTop,
            layoutCollectionHeight,
            layoutCollectionLeft,
            layoutCollectionRight,
            layoutBorderTopTop,
            layoutBorderTopHeight,
            layoutBorderTopLeft,
            layoutBorderTopRight,
            layoutBorderBottomBottom,
            layoutBorderBottomHeight,
            layoutBorderBottomLeft,
            layoutBorderBottomRight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MCameraRecordItem
    {
        let item:MCameraRecordItem = model!.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func config(model:MCameraRecord)
    {
        self.model = model
        collectionView.reloadData()
    }
    
    //MARK: collectionView delegate
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int
        
        guard
        
            let model:MCameraRecord = self.model
        
        else
        {
            return 0
        }
        
        count = model.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MCameraRecordItem = modelAtIndex(index:indexPath)
        let cell:VCameraCellItem = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VCameraCellItem.reusableIdentifier,
            for:indexPath) as! VCameraCellItem
        cell.config(model:item)
        
        return cell
    }
}
