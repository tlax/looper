import UIKit

class VCameraCell:UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var collectionView:VCollection!
    private weak var layoutControlsWidth:NSLayoutConstraint!
    private weak var model:MCameraRecord?
    private weak var controller:CCamera?
    private var listenDrag:Bool
    private let kAnimationDuration:TimeInterval = 0.3
    private let kCellSize:CGFloat = 85
    private let kInterLine:CGFloat = 1
    private let kButtonsWidth:CGFloat = 55
    private let kButtonsHeight:CGFloat = 50
    private let kControlsMaxWidth:CGFloat = 160
    private let kControlsMinWidth:CGFloat = 30
    
    override init(frame:CGRect)
    {
        listenDrag = true
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let collectionView:VCollection = VCollection()
        collectionView.flow.minimumInteritemSpacing = kInterLine
        collectionView.flow.minimumLineSpacing = kInterLine
        collectionView.flow.itemSize = CGSize(
            width:kCellSize,
            height:kCellSize)
        collectionView.flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        collectionView.backgroundColor = UIColor(white:0, alpha:0.05)
        collectionView.alwaysBounceHorizontal = true
        collectionView.registerCell(
            cell:VCameraCellItem.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        self.collectionView = collectionView
        
        let viewControls:VCameraCellControls = VCameraCellControls()
        
        let buttonCheckAll:UIButton = UIButton()
        buttonCheckAll.translatesAutoresizingMaskIntoConstraints = false
        buttonCheckAll.setImage(
            #imageLiteral(resourceName: "assetCameraCheckAll").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonCheckAll.setImage(
            #imageLiteral(resourceName: "assetCameraCheckAll").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonCheckAll.imageView!.tintColor = UIColor(white:0, alpha:0.1)
        buttonCheckAll.imageView!.clipsToBounds = true
        buttonCheckAll.imageView!.contentMode = UIViewContentMode.center
        buttonCheckAll.addTarget(
            self,
            action:#selector(actionCheckAll(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonUncheckAll:UIButton = UIButton()
        buttonUncheckAll.translatesAutoresizingMaskIntoConstraints = false
        buttonUncheckAll.setImage(
            #imageLiteral(resourceName: "assetCameraUncheckAll").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonUncheckAll.setImage(
            #imageLiteral(resourceName: "assetCameraUncheckAll").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonUncheckAll.imageView!.tintColor = UIColor(white:0, alpha:0.1)
        buttonUncheckAll.imageView!.clipsToBounds = true
        buttonUncheckAll.imageView!.contentMode = UIViewContentMode.center
        buttonUncheckAll.addTarget(
            self,
            action:#selector(actionUncheckAll(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let buttonTrash:UIButton = UIButton()
        buttonTrash.translatesAutoresizingMaskIntoConstraints = false
        buttonTrash.setImage(
            #imageLiteral(resourceName: "assetCameraTrash").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonTrash.setImage(
            #imageLiteral(resourceName: "assetCameraTrash").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonTrash.imageView!.tintColor = UIColor(white:0, alpha:0.1)
        buttonTrash.imageView!.clipsToBounds = true
        buttonTrash.imageView!.contentMode = UIViewContentMode.center
        buttonTrash.addTarget(
            self,
            action:#selector(actionTrash(sender:)),
            for:UIControlEvents.touchUpInside)
        
        addSubview(collectionView)
        addSubview(viewControls)
        addSubview(buttonCheckAll)
        addSubview(buttonUncheckAll)
        addSubview(buttonTrash)
        
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
        
        let layoutControlsTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:viewControls,
            toView:self)
        let layoutControlsBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:viewControls,
            toView:self)
        let layoutControlsLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:viewControls,
            toView:self)
        layoutControlsWidth = NSLayoutConstraint.width(
            view:viewControls)
        
        addConstraints([
            layoutCollectionTop,
            layoutCollectionBottom,
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
            layoutTrashWidth,
            layoutControlsTop,
            layoutControlsBottom,
            layoutControlsLeft,
            layoutControlsWidth])
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
        layoutControlsWidth.constant = 0
        let initialRect:CGRect = CGRect(
            x:0,
            y:0,
            width:1,
            height:1)
        collectionView.reloadData()
        collectionView.scrollRectToVisible(
            initialRect,
            animated:false)
    }
    
    //MARK: collectionView delegate
    
    func scrollViewDidScroll(_ scrollView:UIScrollView)
    {
        if listenDrag
        {
            let offsetX:CGFloat = -scrollView.contentOffset.x
            let controlsWidth:CGFloat
            
            if offsetX < 0
            {
                controlsWidth = 0
            }
            else
            {
                controlsWidth = offsetX
            }
            
            layoutControlsWidth.constant = controlsWidth
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView:UIScrollView)
    {
        listenDrag = true
    }
    
    func scrollViewDidEndDragging(_ scrollView:UIScrollView, willDecelerate decelerate:Bool)
    {
        let offsetX:CGFloat = -scrollView.contentOffset.x
        
        if offsetX > kControlsMinWidth
        {
            listenDrag = false
            layoutControlsWidth.constant = kControlsMaxWidth
            collectionView.flow.invalidateLayout()
            
            UIView.animate(
                withDuration:kAnimationDuration)
            { [weak self] in
                    
                self?.layoutIfNeeded()
            }
        }
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, insetForSectionAt section:Int) -> UIEdgeInsets
    {
        let controlsWidth:CGFloat = layoutControlsWidth.constant
        let insets:UIEdgeInsets = UIEdgeInsets(
            top:0,
            left:controlsWidth + kInterLine,
            bottom:0,
            right:kInterLine)
        
        return insets
    }
    
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
