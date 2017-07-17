import UIKit

class VCameraMore:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CCameraMore!
    private weak var collectionView:VCollection!
    private weak var layoutCollectionBottom:NSLayoutConstraint!
    private var closeable:Bool
    private let kCollectionHeight:CGFloat = 290
    private let kAnimationDuration:TimeInterval = 0.2
    
    override init(controller:CController)
    {
        closeable = true
        
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CCameraMore
        
        let blur:VBlur = VBlur.dark()
        
        let closeButton:UIButton = UIButton()
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.backgroundColor = UIColor.clear
        closeButton.addTarget(
            self,
            action:#selector(actionClose(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let collectionView:VCollection = VCollection()
        collectionView.backgroundColor = UIColor.white
        collectionView.bounces = false
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VCameraMoreCellInfo.self)
        collectionView.registerCell(cell:VCameraMoreCellClose.self)
        collectionView.registerCell(cell:VCameraMoreCellActions.self)
        collectionView.registerCell(cell:VCameraMoreCellEmpty.self)
        self.collectionView = collectionView
        
        addSubview(blur)
        addSubview(closeButton)
        addSubview(collectionView)
        
        NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        NSLayoutConstraint.equals(
            view:closeButton,
            toView:self)
        
        layoutCollectionBottom = NSLayoutConstraint.bottomToBottom(
            view:collectionView,
            toView:self,
            constant:kCollectionHeight)
        NSLayoutConstraint.height(
            view:collectionView,
            constant:kCollectionHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:collectionView,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: actions
    
    func actionClose(sender button:UIButton)
    {
        if closeable
        {
            close(completion:nil)
        }
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MCameraMoreItem
    {
        let item:MCameraMoreItem = controller.model.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func close(completion:(() -> ())?)
    {
        closeable = false
        layoutCollectionBottom.constant = kCollectionHeight
        
        UIView.animate(
            withDuration:kAnimationDuration,
            animations:
        { [weak self] in
            
            self?.layoutIfNeeded()
            
        })
        { [weak self] (done:Bool) in
            
            self?.controller.close(completion:completion)
        }
    }
    
    func open()
    {
        layoutCollectionBottom.constant = 0
        
        UIView.animate(
            withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.layoutIfNeeded()
        }
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let item:MCameraMoreItem = modelAtIndex(index:indexPath)
        let width:CGFloat = collectionView.bounds.maxX
        let size:CGSize = CGSize(width:width, height:item.cellHeight)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MCameraMoreItem = modelAtIndex(index:indexPath)
        let cell:VCameraMoreCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            item.reusableIdentifier,
            for:indexPath) as! VCameraMoreCell
        cell.config(controller:controller, model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldSelectItemAt indexPath:IndexPath) -> Bool
    {
        return false
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldHighlightItemAt indexPath:IndexPath) -> Bool
    {
        return false
    }
}
