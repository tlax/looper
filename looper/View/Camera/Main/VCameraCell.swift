import UIKit

class VCameraCell:UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var collectionView:VCollection!
    private weak var layoutCollectionLeft:NSLayoutConstraint!
    private weak var layoutControlsWidth:NSLayoutConstraint!
    private weak var model:MCameraRecord?
    private weak var controller:CCamera?
    private var listenDrag:Bool
    private var extraDrag:Bool
    private var restartScroll:Bool
    private let kAnimationDuration:TimeInterval = 0.3
    private let kCellSize:CGFloat = 70
    private let kInterLine:CGFloat = 1
    private let kButtonsWidth:CGFloat = 55
    private let kButtonsHeight:CGFloat = 50
    private let kControlsMaxWidth:CGFloat = 500
    private let kControlsMidWidth:CGFloat = 60
    private let kControlsMinWidth:CGFloat = 9
    private let kControlsMaxTreshold:CGFloat = 50
    
    override init(frame:CGRect)
    {
        listenDrag = true
        extraDrag = false
        restartScroll = false
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
        
        addSubview(collectionView)
        addSubview(viewControls)
        
        let layoutCollectionTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:collectionView,
            toView:self)
        let layoutCollectionBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:collectionView,
            toView:self)
        layoutCollectionLeft = NSLayoutConstraint.leftToLeft(
            view:collectionView,
            toView:self)
        let layoutCollectionRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:collectionView,
            toView:self)
        
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
            layoutControlsTop,
            layoutControlsBottom,
            layoutControlsLeft,
            layoutControlsWidth])
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(notifiedCameraControlsRestart(sender:)),
            name:Notification.cameraControlsScroll,
            object:nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func touchesMoved(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        
    }
    
    override func touchesEnded(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        
    }
    
    override func touchesCancelled(_ touches:Set<UITouch>, with event:UIEvent?)
    {
        
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
            if restartScroll
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
    
    private func endExtraDrag()
    {
        if extraDrag
        {
            
        }
    }
    
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
        restartScroll = false
        layoutControlsWidth.constant = 0
        layoutCollectionLeft.constant = 0
        
        UIView.animate(
            withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.layoutIfNeeded()
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
        
        if restartScroll
        {
            restartingScroll()
        }
        else if listenDrag && !extraDrag
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
            
            if controlsWidth > kControlsMidWidth
            {
                extraDrag = true
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView:UIScrollView)
    {
        if !listenDrag
        {
            listenDrag = true
            restartScroll = true
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView:UIScrollView, willDecelerate decelerate:Bool)
    {
        let offsetX:CGFloat = -scrollView.contentOffset.x
        
        if offsetX > kControlsMinWidth
        {
            listenDrag = false
            
            let newControlsWidth:CGFloat
            
            if offsetX > kControlsMaxTreshold
            {
                newControlsWidth = kControlsMaxWidth
            }
            else
            {
                newControlsWidth = kControlsMidWidth
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
        
        if restartScroll
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
