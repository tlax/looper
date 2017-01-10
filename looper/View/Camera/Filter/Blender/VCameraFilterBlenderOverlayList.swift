import UIKit

class VCameraFilterBlenderOverlayList:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CCameraFilterBlenderOverlay!
    private weak var collectionView:VCollection!
    private weak var buttonAdd:VCameraFilterBlenderOverlayListAdd!
    private weak var layoutCollectionRight:NSLayoutConstraint!
    private let kAfterInit:TimeInterval = 0.3
    private let kButtonAddSize:CGFloat = 80
    private let kButtonAddTop:CGFloat = 10
    private let kCellSize:CGFloat = 60
    private let kInterline:CGFloat = 2
    
    convenience init(controller:CCameraFilterBlenderOverlay)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let buttonAdd:VCameraFilterBlenderOverlayListAdd = VCameraFilterBlenderOverlayListAdd()
        buttonAdd.addTarget(
            self,
            action:#selector(actionAdd(sender:)),
            for:UIControlEvents.touchUpInside)
        self.buttonAdd = buttonAdd
        
        let buttonDone:UIButton = UIButton()
        buttonDone.translatesAutoresizingMaskIntoConstraints = false
        buttonDone.setTitleColor(
            UIColor.genericLight,
            for:UIControlState.normal)
        buttonDone.setTitleColor(
            UIColor.genericDark,
            for:UIControlState.highlighted)
        buttonDone.setTitle(
            NSLocalizedString("VCameraFilterBlenderOverlayList_done", comment:""),
            for:UIControlState.normal)
        
        let collectionView:VCollection = VCollection()
        collectionView.flow.itemSize = CGSize(width:kCellSize, height:kCellSize)
        collectionView.flow.minimumLineSpacing = kInterline
        collectionView.flow.minimumInteritemSpacing = kInterline
        collectionView.flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        collectionView.flow.sectionInset = UIEdgeInsetsMake(
            0,
            kInterline,
            0,
            kInterline)
        collectionView.alwaysBounceHorizontal = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(
            cell:VCameraFilterBlenderOverlayListCell.self)
        self.collectionView = collectionView
        
        addSubview(buttonAdd)
        addSubview(buttonDone)
        addSubview(collectionView)
        
        let layoutAddTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:buttonAdd,
            toView:self,
            constant:kButtonAddTop)
        let layoutAddHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:buttonAdd,
            constant:kButtonAddSize)
        buttonAdd.layoutLeft = NSLayoutConstraint.leftToLeft(
            view:buttonAdd,
            toView:self,
            constant:-kButtonAddSize)
        let layoutAddWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:buttonAdd,
            constant:kButtonAddSize)
        
        let layoutCollectionBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:collectionView,
            toView:self)
        let layoutCollectionHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:collectionView,
            constant:kCellSize)
        layoutCollectionRight = NSLayoutConstraint.rightToLeft(
            view:collectionView,
            toView:self)
        
        addConstraints([
            layoutAddTop,
            layoutAddHeight,
            buttonAdd.layoutLeft,
            layoutAddWidth])
        
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kAfterInit)
        { [weak self] in
            
            self?.buttonAdd.animateShow()
        }
    }
    
    //MARK: actions
    
    func actionAdd(sender button:UIButton)
    {
        buttonAdd.animateHide()
    }
}
