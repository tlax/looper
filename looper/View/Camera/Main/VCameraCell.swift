import UIKit

class VCameraCell:UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private enum Drag
    {
        case stand
        case restart
        case avoid
    }
    
    private weak var collectionView:VCollection!
    private weak var viewControls:VCameraCellControls!
    private weak var layoutCollectionLeft:NSLayoutConstraint!
    private weak var layoutControlsWidth:NSLayoutConstraint!
    private weak var model:MCameraRecord?
    private weak var controller:CCamera?
    private var drag:Drag
    private let kAnimationDuration:TimeInterval = 0.3
    private let kCellSize:CGFloat = 70
    private let kInterLine:CGFloat = 1
    private let kButtonsWidth:CGFloat = 55
    private let kButtonsHeight:CGFloat = 50
    private let kControlsMinThreshold:CGFloat = 7
    private let kControlsExtraThreshold:CGFloat = 30
    private let kControlsMenuThreshold:CGFloat = 50
    private let kControlsMaxThreshold:CGFloat = 180
    private let kExtraSpeed:CGFloat = 3
    
    override init(frame:CGRect)
    {
        drag = Drag.stand
        
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let collectionView:VCollection = VCollection()
        collectionView.flow.minimumInteritemSpacing = kInterLine
        collectionView.flow.minimumLineSpacing = kInterLine
        collectionView.flow.itemSize = CGSize(
            width:kCellSize,
            height:kCellSize)
        collectionView.flow.sectionInset = UIEdgeInsets(
            top:0,
            left:kInterLine,
            bottom:0,
            right:kInterLine)
        collectionView.flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        collectionView.backgroundColor = UIColor.black
        collectionView.alwaysBounceHorizontal = true
        collectionView.registerCell(
            cell:VCameraCellItem.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        self.collectionView = collectionView
        
        let viewControls:VCameraCellControls = VCameraCellControls()
        viewControls.buttonMore.addTarget(
            self,
            action:#selector(actionMore(sender:)),
            for:UIControlEvents.touchUpInside)
        viewControls.buttonCheckAll.addTarget(
            self,
            action:#selector(actionCheckAll(sender:)),
            for:UIControlEvents.touchUpInside)
        viewControls.buttonUncheckAll.addTarget(
            self,
            action:#selector(actionUncheckAll(sender:)),
            for:UIControlEvents.touchUpInside)
        self.viewControls = viewControls
        
        addSubview(collectionView)
        addSubview(viewControls)
        
        NSLayoutConstraint.equalsVertical(
            view:collectionView,
            toView:self)
        layoutCollectionLeft = NSLayoutConstraint.leftToLeft(
            view:collectionView,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:collectionView,
            toView:self)
        
        NSLayoutConstraint.equalsVertical(
            view:viewControls,
            toView:self)
        NSLayoutConstraint.leftToLeft(
            view:viewControls,
            toView:self)
        layoutControlsWidth = NSLayoutConstraint.width(
            view:viewControls)
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(notifiedCameraControlsRestart(sender:)),
            name:Notification.cameraControlsScroll,
            object:nil)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: notifications
    
    func notifiedCameraControlsRestart(sender notification:Notification)
    {
        guard
        
            let notificator:VCameraCell = notification.object as? VCameraCell
        
        else
        {
            return
        }
        
        if notificator !== self
        {
            if drag == Drag.restart
            {
                restartingScroll()
            }
        }
    }
    
    //MARK: actions
    
    func actionCheckAll(sender button:UIButton)
    {
        restartingScroll()
        changeAllItems(active:true)
    }
    
    func actionUncheckAll(sender button:UIButton)
    {
        restartingScroll()
        changeAllItems(active:false)
    }
    
    func actionMore(sender button:UIButton)
    {
        showMore()
    }
    
    //MARK: private
    
    private func showMore()
    {
        restartingScroll()
        
        guard
            
            let model:MCameraRecord = self.model
            
        else
        {
            return
        }
        
        controller?.showMore(item:model)
    }
    
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
                self?.controller?.viewCamera.header?.refresh()
            }
        }
    }
    
    private func modelAtIndex(index:IndexPath) -> MCameraRecordItem
    {
        let item:MCameraRecordItem = model!.items[index.item]
        
        return item
    }
    
    private func restartingScroll()
    {
        drag = Drag.avoid
        layoutControlsWidth.constant = 0
        layoutCollectionLeft.constant = 0
     
        UIView.animate(
            withDuration:kAnimationDuration,
            animations:
        { [weak self] in
            
            self?.layoutIfNeeded()
                
        })
        { [weak self] (done:Bool) in
            
            self?.drag = Drag.stand
        }
    }
    
    private func notifyRestartScrolls()
    {
        NotificationCenter.default.post(
            name:Notification.cameraControlsScroll,
            object:self)
    }
    
    //MARK: public
    
    func config(model:MCameraRecord, controller:CCamera)
    {
        self.model = model
        self.controller = controller
        layoutControlsWidth.constant = 0
        layoutCollectionLeft.constant = 0
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
        notifyRestartScrolls()
        
        switch drag
        {
        case Drag.stand:
        
            let offsetX:CGFloat = -scrollView.contentOffset.x
            let controlsWidth:CGFloat
            
            if offsetX < 0
            {
                controlsWidth = 0
            }
            else
            {
                let extraDelta:CGFloat = offsetX - kControlsExtraThreshold
                let extraWidth:CGFloat
                
                if extraDelta > 0
                {
                    extraWidth = kExtraSpeed * extraDelta
                }
                else
                {
                    extraWidth = 0
                }
                
                controlsWidth = offsetX + extraWidth
            }
            
            layoutControlsWidth.constant = controlsWidth
            
            break
            
        case Drag.restart:
            
            restartingScroll()
            
            break
            
        case Drag.avoid:
            break
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView:UIScrollView)
    {
        switch drag
        {
        case Drag.restart:
         
            drag = Drag.stand
            
            break
            
        case Drag.avoid:
            
            drag = Drag.restart
            
            break
            
        default:
            
            break
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView:UIScrollView, willDecelerate decelerate:Bool)
    {
        let controlsWidth:CGFloat = layoutControlsWidth.constant
        
        if controlsWidth > kControlsMinThreshold
        {
            if controlsWidth > kControlsMaxThreshold
            {
                showMore()
            }
            else
            {
                drag = Drag.avoid
                
                let newControlsWidth:CGFloat
                
                if controlsWidth > kControlsMenuThreshold
                {
                    newControlsWidth = viewControls.allButtonsWidth
                }
                else
                {
                    newControlsWidth = viewControls.kButtonsWidth
                }
                
                layoutControlsWidth.constant = newControlsWidth
                layoutCollectionLeft.constant = newControlsWidth
                
                UIView.animate(
                    withDuration:kAnimationDuration)
                { [weak self] in
                    
                    self?.layoutIfNeeded()
                }
            }
        }
        else
        {
            drag = Drag.stand
        }
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
        
        if drag == Drag.restart
        {
            restartingScroll()
        }
        else
        {
            notifyRestartScrolls()
            
            let item:MCameraRecordItem = modelAtIndex(index:indexPath)
            let cell:VCameraCellItem = collectionView.cellForItem(
                at:indexPath) as! VCameraCellItem
            item.active = !item.active
            
            cell.update()
            controller?.viewCamera.header?.refresh()
        }
    }
}
