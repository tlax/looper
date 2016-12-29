import UIKit

class VCameraCell:UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var collectionView:VCollection!
    private weak var model:MCameraRecord?
    private weak var controller:CCamera?
    private let kCollectionHeight:CGFloat = 70
    private let kCellSize:CGFloat = 68
    private let kInterLine:CGFloat = 1
    private let kBorderHeight:CGFloat = 1
    private let kButtonsWidth:CGFloat = 55
    private let kButtonsHeight:CGFloat = 50
    
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
            left:kInterLine,
            bottom:0,
            right:kInterLine)
        collectionView.backgroundColor = UIColor(white:0, alpha:0.05)
        collectionView.alwaysBounceHorizontal = true
        collectionView.registerCell(
            cell:VCameraCellItem.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        self.collectionView = collectionView
        
        let buttonCheckAll:UIButton = UIButton()
        buttonCheckAll.translatesAutoresizingMaskIntoConstraints = false
        buttonCheckAll.setImage(
            #imageLiteral(resourceName: "assetCameraCheckAll"),
            for:UIControlState.normal)
        buttonCheckAll.imageView!.clipsToBounds = true
        buttonCheckAll.imageView!.contentMode = UIViewContentMode.center
        buttonCheckAll.addTarget(
            self,
            action:#selector(actionCheckAll(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonUncheckAll:UIButton = UIButton()
        buttonUncheckAll.translatesAutoresizingMaskIntoConstraints = false
        buttonUncheckAll.setImage(
            #imageLiteral(resourceName: "assetCameraUncheckAll"),
            for:UIControlState.normal)
        buttonUncheckAll.imageView!.clipsToBounds = true
        buttonUncheckAll.imageView!.contentMode = UIViewContentMode.center
        buttonUncheckAll.addTarget(
            self,
            action:#selector(actionUncheckAll(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonTrash:UIButton = UIButton()
        buttonTrash.translatesAutoresizingMaskIntoConstraints = false
        buttonTrash.setImage(
            #imageLiteral(resourceName: "assetCameraTrash"),
            for:UIControlState.normal)
        buttonTrash.imageView!.clipsToBounds = true
        buttonTrash.imageView!.contentMode = UIViewContentMode.center
        buttonTrash.addTarget(
            self,
            action:#selector(actionTrash(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(collectionView)
        addSubview(buttonCheckAll)
        addSubview(buttonUncheckAll)
        addSubview(buttonTrash)
        
        let layoutCollectionTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:collectionView,
            toView:self)
        let layoutCollectionHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:collectionView,
            constant:kCollectionHeight)
        let layoutCollectionLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:collectionView,
            toView:self)
        let layoutCollectionRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:collectionView,
            toView:self)
        
        let layoutCheckAllTop:NSLayoutConstraint = NSLayoutConstraint.topToBottom(
            view:buttonCheckAll,
            toView:collectionView)
        let layoutCheckAllHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:buttonCheckAll,
            constant:kButtonsHeight)
        let layoutCheckAllLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:buttonCheckAll,
            toView:self)
        let layoutCheckAllWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:buttonCheckAll,
            constant:kButtonsWidth)
        
        let layoutUncheckAllTop:NSLayoutConstraint = NSLayoutConstraint.topToBottom(
            view:buttonUncheckAll,
            toView:collectionView)
        let layoutUncheckAllHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:buttonUncheckAll,
            constant:kButtonsHeight)
        let layoutUncheckAllLeft:NSLayoutConstraint = NSLayoutConstraint.leftToRight(
            view:buttonUncheckAll,
            toView:buttonCheckAll)
        let layoutUncheckAllWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:buttonUncheckAll,
            constant:kButtonsWidth)
        
        let layoutTrashTop:NSLayoutConstraint = NSLayoutConstraint.topToBottom(
            view:buttonTrash,
            toView:collectionView)
        let layoutTrashHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:buttonTrash,
            constant:kButtonsHeight)
        let layoutTrashLeft:NSLayoutConstraint = NSLayoutConstraint.leftToRight(
            view:buttonTrash,
            toView:buttonUncheckAll)
        let layoutTrashWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:buttonTrash,
            constant:kButtonsWidth)
        
        addConstraints([
            layoutCollectionTop,
            layoutCollectionHeight,
            layoutCollectionLeft,
            layoutCollectionRight,
            layoutCheckAllTop,
            layoutCheckAllHeight,
            layoutCheckAllLeft,
            layoutCheckAllWidth,
            layoutUncheckAllTop,
            layoutUncheckAllHeight,
            layoutUncheckAllLeft,
            layoutUncheckAllWidth,
            layoutTrashTop,
            layoutTrashHeight,
            layoutTrashLeft,
            layoutTrashWidth])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: actions
    
    func actionCheckAll(sender button:UIButton)
    {
        changeAllItems(active:true)
    }
    
    func actionUncheckAll(sender button:UIButton)
    {
        changeAllItems(active:false)
    }
    
    func actionTrash(sender button:UIButton)
    {
        guard
            
            let model:MCameraRecord = self.model
            
        else
        {
            return
        }
        
        controller?.trash(item:model)
    }
    
    //MARK: private
    
    private func changeAllItems(active:Bool)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            guard
            
                let model:MCameraRecord = self?.model
            
            else
            {
                return
            }
            
            for item:MCameraRecordItem in model.items
            {
                item.active = active
            }
            
            DispatchQueue.main.async
            { [weak self] in
                
                self?.collectionView.reloadData()
            }
        }
    }
    
    private func modelAtIndex(index:IndexPath) -> MCameraRecordItem
    {
        let item:MCameraRecordItem = model!.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func config(model:MCameraRecord, controller:CCamera)
    {
        self.model = model
        self.controller = controller
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
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        collectionView.selectItem(
            at:nil,
            animated:false,
            scrollPosition:UICollectionViewScrollPosition())
        
        let item:MCameraRecordItem = modelAtIndex(index:indexPath)
        let cell:VCameraCellItem = collectionView.cellForItem(
            at:indexPath) as! VCameraCellItem
        item.active = !item.active
        cell.update()
    }
}
