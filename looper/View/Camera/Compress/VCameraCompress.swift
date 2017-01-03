import UIKit

class VCameraCompress:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CCameraCompress!
    private weak var collectionView:VCollection!
    private let kBarHeight:CGFloat = 64
    private let kCellHeight:CGFloat = 90
    private let kInterLine:CGFloat = 2
    private let kCollectionTop:CGFloat = 67
    private let kCollectionBottom:CGFloat = 20
    private let kAfterSelect:TimeInterval = 0.2
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        backgroundColor = UIColor(white:0.98, alpha:1)
        self.controller = controller as? CCameraCompress
        
        let viewBar:VCameraCompressBar = VCameraCompressBar(
            controller:self.controller)
        
        let collectionView:VCollection = VCollection()
        collectionView.flow.minimumLineSpacing = kInterLine
        collectionView.flow.sectionInset = UIEdgeInsets(
            top:kCollectionTop,
            left:0,
            bottom:kCollectionBottom,
            right:0)
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VCameraCompressCell.self)
        self.collectionView = collectionView
        
        addSubview(collectionView)
        addSubview(viewBar)
        
        let layoutBarTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:viewBar,
            toView:self)
        let layoutBarHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:viewBar,
            constant:kBarHeight)
        let layoutBarLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewBar,
            toView:self)
        let layoutBarRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:viewBar,
            toView:self)
        
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
            layoutBarTop,
            layoutBarHeight,
            layoutBarLeft,
            layoutBarRight,
            layoutCollectionTop,
            layoutCollectionBottom,
            layoutCollectionLeft,
            layoutCollectionRight])
        
        var indexSelected:Int?
        let countItems:Int = self.controller.modelCompress.items.count
        
        for indexItem:Int in 0 ..< countItems
        {
            let item:MCameraCompressItem = self.controller.modelCompress.items[indexItem]
            
            if item === self.controller.modelCompress.currentCompress
            {
                indexSelected = indexItem
                
                break
            }
        }
        
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kAfterSelect)
        { [weak self] in
            
            guard
                
                let index:Int = indexSelected
                
            else
            {
                return
            }
            
            let indexPath:IndexPath = IndexPath(item:index, section:0)
            self?.collectionView.selectItem(
                at:indexPath,
                animated:false,
                scrollPosition:UICollectionViewScrollPosition.top)
        }
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MCameraCompressItem
    {
        let item:MCameraCompressItem = controller.modelCompress.items[index.item]
        
        return item
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width:CGFloat = collectionView.bounds.maxX
        let size:CGSize = CGSize(width:width, height:kCellHeight)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.modelCompress.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MCameraCompressItem = modelAtIndex(index:indexPath)
        let cell:VCameraCompressCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VCameraCompressCell.reusableIdentifier,
            for:indexPath) as! VCameraCompressCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        let item:MCameraCompressItem = modelAtIndex(index:indexPath)
        controller.modelCompress.currentCompress = item
    }
}
