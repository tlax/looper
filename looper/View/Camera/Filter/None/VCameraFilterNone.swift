import UIKit

class VCameraFilterNone:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var collectionView:VCollection!
    private weak var controller:CCameraFilterNone!
    private weak var spinner:VSpinner!
    private let kHeaderHeight:CGFloat = 67
    private let kCollectionTop:CGFloat = 10
    private let kCollectionBottom:CGFloat = 20
    private let kCellHeight:CGFloat = 90
    private let kInterLine:CGFloat = 10
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CCameraFilterNone
        
        let collectionView:VCollection = VCollection()
        collectionView.flow.headerReferenceSize = CGSize(
            width:0,
            height:kHeaderHeight)
        collectionView.flow.minimumLineSpacing = kInterLine
        collectionView.flow.sectionInset = UIEdgeInsets(
            top:kCollectionTop,
            left:0,
            bottom:kCollectionBottom,
            right:0)
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VCameraFilterNoneCell.self)
        collectionView.registerHeader(header:VCameraFilterNoneHeader.self)
        self.collectionView = collectionView
        
        let spinner:VSpinner = VSpinner()
        spinner.stopAnimating()
        self.spinner = spinner
        
        addSubview(spinner)
        addSubview(collectionView)
        
        NSLayoutConstraint.equals(
            view:collectionView,
            toView:self)
        NSLayoutConstraint.equals(
            view:spinner,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    deinit
    {
        spinner.stopAnimating()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MCameraRecord
    {
        let item:MCameraRecord = MSession.sharedInstance.camera!.activeRecords![index.item]
        
        return item
    }
    
    //MARK: public
    
    func refresh()
    {
        spinner.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData()
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let width:CGFloat = collectionView.bounds.maxX
        let size:CGSize = CGSize(width:width, height:kCellHeight)
        
        return size
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int
        
        if let records:[MCameraRecord] = MSession.sharedInstance.camera!.activeRecords
        {
            count = records.count
        }
        else
        {
            count = 0
        }
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, viewForSupplementaryElementOfKind kind:String, at indexPath:IndexPath) -> UICollectionReusableView
    {
        let header:VCameraFilterNoneHeader = collectionView.dequeueReusableSupplementaryView(
            ofKind:kind,
            withReuseIdentifier:
            VCameraFilterNoneHeader.reusableIdentifier,
            for:indexPath) as! VCameraFilterNoneHeader
        header.controller = controller
        
        return header
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MCameraRecord = modelAtIndex(index:indexPath)
        let cell:VCameraFilterNoneCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VCameraFilterNoneCell.reusableIdentifier,
            for:indexPath) as! VCameraFilterNoneCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        collectionView.isHidden = true
        spinner.startAnimating()
        let item:MCameraRecord = modelAtIndex(index:indexPath)
        controller.selected(record:item)
    }
}
