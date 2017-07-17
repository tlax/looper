import UIKit

class VCameraPicker:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var viewBar:VCameraPickerBar!
    private weak var controller:CCameraPicker!
    private weak var collectionView:VCollection!
    private weak var spinner:VSpinner!
    private var imageSize:CGSize!
    private let kCollectionBottom:CGFloat = 20
    private let kInterLine:CGFloat = 1
    private let kBarHeight:CGFloat = 70
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CCameraPicker
        
        let spinner:VSpinner = VSpinner()
        self.spinner = spinner
        
        let viewBar:VCameraPickerBar = VCameraPickerBar(
            controller:self.controller)
        self.viewBar = viewBar
        
        let collectionView:VCollection = VCollection()
        collectionView.isHidden = true
        collectionView.alwaysBounceVertical = true
        collectionView.allowsMultipleSelection = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell:VCameraPickerCell.self)
        
        collectionView.flow.minimumLineSpacing = kInterLine
        collectionView.flow.sectionInset = UIEdgeInsets(
            top:kInterLine,
            left:kInterLine,
            bottom:kCollectionBottom,
            right:kInterLine)
        
        self.collectionView = collectionView
        
        addSubview(spinner)
        addSubview(viewBar)
        addSubview(collectionView)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func layoutSubviews()
    {
        computeImageSize()
        collectionView.collectionViewLayout.invalidateLayout()
        
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func computeImageSize()
    {
        let width:CGFloat = bounds.maxX - kInterLine
        let proximate:CGFloat = floor(width / MCameraPicker.kThumbnailSize)
        let size:CGFloat = (width / proximate) - kInterLine
        imageSize = CGSize(width:size, height:size)
    }
    
    private func modelAtIndex(index:IndexPath) -> MCameraPickerItem
    {
        let item:MCameraPickerItem = controller.model.items[index.item]
        
        return item
    }
    
    private func updateBar()
    {
        guard
            
            let amount:Int = collectionView.indexPathsForSelectedItems?.count
            
        else
        {
            return
        }
        
        viewBar.config(amount:amount)
    }
    
    //MARK: collectionView delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        return imageSize
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
        let item:MCameraPickerItem = modelAtIndex(index:indexPath)
        let cell:VCameraPickerCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VCameraPickerCell.reusableIdentifier,
            for:indexPath) as! VCameraPickerCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        updateBar()
    }
    
    func collectionView(_ collectionView:UICollectionView, didDeselectItemAt indexPath:IndexPath)
    {
        updateBar()
    }
}
