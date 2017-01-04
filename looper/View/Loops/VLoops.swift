import UIKit

class VLoops:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CLoops!
    private weak var collectionView:VCollection!
    private weak var spinner:VSpinner!
    private let kCollectionTop:CGFloat = 64
    private let kCollectionBottom:CGFloat = 20
    private let kInterline:CGFloat = 30
    private let kAddCellHeight:CGFloat = 70
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CLoops
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        let collectionView:VCollection = VCollection()
        collectionView.flow.minimumLineSpacing = kInterline
        collectionView.flow.sectionInset = UIEdgeInsets(
            top:kCollectionTop,
            left:0,
            bottom:kCollectionBottom,
            right:0)
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VLoopsCell.self)
        self.collectionView = collectionView
        
        addSubview(spinner)
        addSubview(collectionView)
        
        let constraintsCollection:[NSLayoutConstraint] = NSLayoutConstraint.equals(
            view:collectionView,
            parent:self)
        
        let constraintsSpinner:[NSLayoutConstraint] = NSLayoutConstraint.equals(
            view:spinner,
            parent:self)
        
        addConstraints(constraintsCollection)
        addConstraints(constraintsSpinner)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MLoopsItem
    {
        let item:MLoopsItem = controller.model.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func loopsLoaded()
    {
        spinner.stopAnimating()
        collectionView.reloadData()
    }
    
    //MARK: collectionView delegate
    
    func scrollViewDidScroll(_ scrollView:UIScrollView)
    {
        NotificationCenter.default.post(
            name:Notification.loopsPause,
            object:nil)
        
        let offset:CGPoint = scrollView.contentOffset
        let offsetY:CGFloat = offset.y
        controller.parentController.viewParent.scrollDidScroll(offsetY:offsetY)
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let width:CGFloat = collectionView.bounds.maxX
        let size:CGSize = CGSize(
            width:width,
            height:width + kAddCellHeight)
        
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
        let item:MLoopsItem = modelAtIndex(index:indexPath)
        let cell:VLoopsCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VLoopsCell.reusableIdentifier,
            for:indexPath) as! VLoopsCell
        cell.config(model:item, controller:controller)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldHighlightItemAt indexPath:IndexPath) -> Bool
    {
        return false
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldSelectItemAt indexPath:IndexPath) -> Bool
    {
        return false
    }
}
