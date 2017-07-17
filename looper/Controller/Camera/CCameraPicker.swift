import UIKit
import Photos

class CCameraPicker:CController
{
    let model:MCameraPicker
    private weak var camera:CCamera!
    private weak var record:MCameraRecord?
    private weak var viewPicker:VCameraPicker!
    
    init(camera:CCamera, record:MCameraRecord?)
    {
        model = MCameraPicker()
        
        super.init()
        self.camera = camera
        self.record = record
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func loadView()
    {
        let viewPicker:VCameraPicker = VCameraPicker(controller:self)
        self.viewPicker = viewPicker
        view = viewPicker
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        switch PHPhotoLibrary.authorizationStatus()
        {
        case PHAuthorizationStatus.denied,
             PHAuthorizationStatus.restricted:
            
            authDenied()
            
            break
            
        case PHAuthorizationStatus.notDetermined:
            
            PHPhotoLibrary.requestAuthorization()
            { [weak self] (status:PHAuthorizationStatus) in
                
                if status == PHAuthorizationStatus.authorized
                {
                    self?.authorized()
                }
                else
                {
                    self?.authDenied()
                }
            }
            
            break
            
        case PHAuthorizationStatus.authorized:
            
            authorized()
            
            break
        }
    }
    
    //MARK: private
    
    private func imagesLoaded()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewPicker.imagesLoaded()
        }
    }
    
    private func selectedItems() -> [MCameraPickerItem]
    {
        var items:[MCameraPickerItem] = []
        
        guard
            
            let selectedItems:[IndexPath] = viewPicker.collectionView.indexPathsForSelectedItems
            
        else
        {
            return items
        }
        
        for indexSelected:IndexPath in selectedItems
        {
            let itemIndex:Int = indexSelected.item
            let item:MCameraPickerItem = model.items[itemIndex]
            items.append(item)
        }
        
        items.sort
        { (itemA, itemB) -> Bool in
            
            return itemA.selectedAt < itemB.selectedAt
        }
        
        return items
    }
    
    private func render()
    {
        let items:[MCameraPickerItem] = selectedItems()
        
        guard
        
            let camera:MCamera = MSession.sharedInstance.camera
        
        else
        {
            return
        }
        
        guard
        
            let record:MCameraRecord = self.record
        
        else
        {
            camera.renderImages(modelImages:items)
            
            return
        }
        
        camera.renderImages(record:record, modelImages:items)
    }
    
    private func close()
    {
        parentController.pop(vertical:CParent.TransitionVertical.fromTop)
    }
    
    private func authDenied()
    {
        let errorMessage:String = NSLocalizedString("CCameraPicker_authDenied", comment:"")
        VAlert.message(message:errorMessage)
    }
    
    private func errorLoadingCameraRoll()
    {
        let errorMessage:String = NSLocalizedString("CCameraPicker_noCameraRoll", comment:"")
        VAlert.message(message:errorMessage)
    }
    
    private func authorized()
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.loadCameraRoll()
        }
    }
    
    private func loadCameraRoll()
    {
        model.items = []
        
        let collectionResult:PHFetchResult = PHAssetCollection.fetchAssetCollections(
            with:PHAssetCollectionType.smartAlbum,
            subtype:PHAssetCollectionSubtype.smartAlbumUserLibrary,
            options:nil)
        
        guard
            
            let cameraRoll:PHAssetCollection = collectionResult.firstObject
            
        else
        {
            errorLoadingCameraRoll()
            
            return
        }
        
        let fetchOptions:PHFetchOptions = PHFetchOptions()
        let sortNewest:NSSortDescriptor = NSSortDescriptor(
            key:"creationDate",
            ascending:false)
        let predicateImages:NSPredicate = NSPredicate(
            format:"mediaType = %d",
            PHAssetMediaType.image.rawValue)
        fetchOptions.sortDescriptors = [sortNewest]
        fetchOptions.predicate = predicateImages
        
        let assetsResult:PHFetchResult = PHAsset.fetchAssets(
            in:cameraRoll,
            options:fetchOptions)
        let countAssets:Int = assetsResult.count
        
        for indexAsset:Int in 0 ..< countAssets
        {
            let asset:PHAsset = assetsResult[indexAsset]
            let uploadItem:MCameraPickerItem = MCameraPickerItem(asset:asset)
            
            model.items.append(uploadItem)
        }
        
        imagesLoaded()
    }
    
    //MARK: public
    
    func commit()
    {
        render()
        close()
    }
    
    func cancel()
    {
        close()
    }
}
