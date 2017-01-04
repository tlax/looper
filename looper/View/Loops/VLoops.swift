import UIKit

class VLoops:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CLoops!
    private weak var collectionView:VCollection!
    private weak var spinner:VSpinner!
    private let kCollectionTop:CGFloat = 84
    private let kCollectionBottom:CGFloat = 20
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CLoops
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        let collectionView:VCollection = VCollection()
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
        
        let layoutSpinnerTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:spinner,
            toView:self)
        let layoutSpinnerBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:spinner,
            toView:self)
        let layoutSpinnerLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:spinner,
            toView:self)
        let layoutSpinnerRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:spinner,
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
            layoutSpinnerTop,
            layoutSpinnerBottom,
            layoutSpinnerLeft,
            layoutSpinnerRight,
            layoutCollectionTop,
            layoutCollectionBottom,
            layoutCollectionLeft,
            layoutCollectionRight])
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
        let offset:CGPoint = scrollView.contentOffset
        let offsetY:CGFloat = offset.y
        controller.parentController.viewParent.scrollDidScroll(offsetY:offsetY)
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let width:CGFloat = collectionView.bounds.maxX
        let size:CGSize = CGSize(width:width, height:width)
        
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
        cell.config(model:item)
        
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
