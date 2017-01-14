import UIKit

class VCameraFilterBlenderOverlayList:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CCameraFilterBlenderOverlay!
    private weak var collectionView:VCollection!
    private weak var buttonAdd:VCameraFilterBlenderOverlayListAdd!
    private weak var layoutCollectionRight:NSLayoutConstraint!
    private weak var layoutDoneLeft:NSLayoutConstraint!
    private let kAfterInit:TimeInterval = 0.3
    private let kDeselectTime:TimeInterval = 0.3
    private let kButtonAddSize:CGFloat = 80
    private let kButtonAddTop:CGFloat = 50
    private let kButtonDoneWidth:CGFloat = 120
    private let kButtonDoneHeight:CGFloat = 32
    private let kButtonDoneBottom:CGFloat = -16
    private let kCellSize:CGFloat = 80
    private let kInterline:CGFloat = 2
    
    convenience init(controller:CCameraFilterBlenderOverlay)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let screenWidth:CGFloat = UIScreen.main.bounds.width
        let countCells:Int = MSession.sharedInstance.camera!.activeRecords!.count
        let cellsWidth:CGFloat = (CGFloat(countCells) * (kCellSize + kInterline)) + kInterline
        let remainScreenWidth:CGFloat = screenWidth - cellsWidth
        let marginScreenWidth:CGFloat = remainScreenWidth / 2.0
        let marginSides:CGFloat
        
        if marginScreenWidth > 0
        {
            marginSides = marginScreenWidth
        }
        else
        {
            marginSides = kInterline
        }
        
        let buttonAdd:VCameraFilterBlenderOverlayListAdd = VCameraFilterBlenderOverlayListAdd()
        buttonAdd.addTarget(
            self,
            action:#selector(actionAdd(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonAdd = buttonAdd
        
        let buttonDone:UIButton = UIButton()
        buttonDone.clipsToBounds = true
        buttonDone.backgroundColor = UIColor.genericLight
        buttonDone.translatesAutoresizingMaskIntoConstraints = false
        buttonDone.setTitleColor(
            UIColor.white,
            for:UIControlState.normal)
        buttonDone.setTitleColor(
            UIColor(white:1, alpha:0.2),
            for:UIControlState.highlighted)
        buttonDone.setTitle(
            NSLocalizedString("VCameraFilterBlenderOverlayList_done", comment:""),
            for:UIControlState.normal)
        buttonDone.titleLabel!.font = UIFont.bold(size:16)
        buttonDone.addTarget(
            self,
            action:#selector(actionDone(sender:)),
            for:UIControlEvents.touchUpInside)
        buttonDone.layer.cornerRadius = kButtonDoneHeight / 2.0
        
        let collectionView:VCollection = VCollection()
        collectionView.flow.itemSize = CGSize(width:kCellSize, height:kCellSize)
        collectionView.flow.minimumLineSpacing = kInterline
        collectionView.flow.minimumInteritemSpacing = kInterline
        collectionView.flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        collectionView.flow.sectionInset = UIEdgeInsetsMake(
            0,
            marginSides,
            0,
            marginSides)
        collectionView.alwaysBounceHorizontal = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(
            cell:VCameraFilterBlenderOverlayListCell.self)
        self.collectionView = collectionView
        
        addSubview(buttonAdd)
        addSubview(buttonDone)
        addSubview(collectionView)
        
        NSLayoutConstraint.topToTop(
            view:buttonAdd,
            toView:self,
            constant:kButtonAddTop)
        NSLayoutConstraint.height(
            view:buttonAdd,
            constant:kButtonAddSize)
        buttonAdd.layoutLeft = NSLayoutConstraint.leftToLeft(
            view:buttonAdd,
            toView:self,
            constant:-kButtonAddSize)
        NSLayoutConstraint.width(
            view:buttonAdd,
            constant:kButtonAddSize)
        
        NSLayoutConstraint.bottomToBottom(
            view:collectionView,
            toView:self)
        NSLayoutConstraint.height(
            view:collectionView,
            constant:kCellSize)
        layoutCollectionRight = NSLayoutConstraint.rightToLeft(
            view:collectionView,
            toView:buttonAdd)
        NSLayoutConstraint.width(
            view:collectionView,
            toView:self)
        
        NSLayoutConstraint.height(
            view:buttonDone,
            constant:kButtonDoneHeight)
        NSLayoutConstraint.bottomToTop(
            view:buttonDone,
            toView:collectionView,
            constant:kButtonDoneBottom)
        NSLayoutConstraint.width(
            view:buttonDone,
            constant:kButtonDoneWidth)
        layoutDoneLeft = NSLayoutConstraint.leftToLeft(
            view:buttonDone,
            toView:collectionView)
        
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kAfterInit)
        { [weak self] in
            
            self?.buttonAdd.animateShow()
        }
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remainAdd:CGFloat = width - kButtonAddSize
        let marginAdd:CGFloat = remainAdd / 2.0
        let remainDone:CGFloat = width - kButtonDoneWidth
        let marginDone:CGFloat = remainDone / 2.0
        layoutCollectionRight.constant = -marginAdd
        layoutDoneLeft.constant = marginDone
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionAdd(sender button:UIButton)
    {
        buttonAdd.animateHide()
    }
    
    func actionDone(sender button:UIButton)
    {
        buttonAdd.animateShow()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MCameraRecord
    {
        let item:MCameraRecord = MSession.sharedInstance.camera!.activeRecords![index.item]
        
        return item
    }
    
    //MARK: collectionView delegate
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = MSession.sharedInstance.camera!.activeRecords!.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MCameraRecord = modelAtIndex(index:indexPath)
        let cell:VCameraFilterBlenderOverlayListCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VCameraFilterBlenderOverlayListCell.reusableIdentifier,
            for:indexPath) as! VCameraFilterBlenderOverlayListCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        let item:MCameraRecord = modelAtIndex(index:indexPath)
        controller.viewOverlay.addPiece(model:item)
        
        buttonAdd.animateShow()
        
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kDeselectTime)
        { [weak collectionView] in
            
            collectionView?.selectItem(
                at:nil,
                animated:false,
                scrollPosition:UICollectionViewScrollPosition())
        }
    }
}
