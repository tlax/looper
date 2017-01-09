import UIKit

class VCameraFilterBlender:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CCameraFilterBlender!
    private weak var collectionView:VCollection!
    private let kContentTop:CGFloat = 20
    private let kButtonsWidth:CGFloat = 55
    private let kButtonsHeight:CGFloat = 44
    
    override init(controller:CController)
    {
        super.init(controller:controller)
        self.controller = controller as? CCameraFilterBlender
        
        let backButton:UIButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        backButton.setImage(
            #imageLiteral(resourceName: "assetGenericBack").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        backButton.imageView!.contentMode = UIViewContentMode.center
        backButton.imageView!.clipsToBounds = true
        backButton.imageView!.tintColor = UIColor(white:0, alpha:0.2)
        backButton.addTarget(
            self,
            action:#selector(actionBack(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let nextButton:UIButton = UIButton()
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setImage(
            #imageLiteral(resourceName: "assetGenericNext").withRenderingMode(
                UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        nextButton.setImage(
            #imageLiteral(resourceName: "assetGenericNext").withRenderingMode(
                UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        nextButton.imageView!.contentMode = UIViewContentMode.center
        nextButton.imageView!.tintColor = UIColor(white:0, alpha:0.2)
        nextButton.imageView!.clipsToBounds = true
        nextButton.addTarget(
            self,
            action:#selector(actionNext(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let title:UILabel = UILabel()
        title.isUserInteractionEnabled = false
        title.translatesAutoresizingMaskIntoConstraints = false
        title.backgroundColor = UIColor.clear
        title.font = UIFont.regular(size:14)
        title.textAlignment = NSTextAlignment.center
        title.textColor = UIColor.black
        title.text = NSLocalizedString("VCameraFilterBlender_title", comment:"")
        
        let collectionView:VCollection = VCollection()
        collectionView.flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        collectionView.alwaysBounceHorizontal = true
        self.collectionView = collectionView
        
        addSubview(title)
        addSubview(collectionView)
        addSubview(backButton)
        addSubview(nextButton)
        
        let constraintsCollection:[NSLayoutConstraint] = NSLayoutConstraint.equals(
            view:collectionView,
            parent:self)
        
        let layoutBackTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:backButton,
            toView:self,
            constant:kContentTop)
        let layoutBackHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:backButton,
            constant:kButtonsHeight)
        let layoutBackLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:backButton,
            toView:self)
        let layoutBackWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:backButton,
            constant:kButtonsWidth)
        
        let layoutNextTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:nextButton,
            toView:self,
            constant:kContentTop)
        let layoutNextHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:nextButton,
            constant:kButtonsHeight)
        let layoutNextRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:nextButton,
            toView:self)
        let layoutNextWidth:NSLayoutConstraint = NSLayoutConstraint.width(
            view:nextButton,
            constant:kButtonsWidth)
        
        let layoutTitleTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:title,
            toView:self,
            constant:kContentTop)
        let layoutTitleHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:title,
            constant:kButtonsHeight)
        let layoutTitleLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:title,
            toView:self)
        let layoutTitleRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:title,
            toView:self)
        
        addConstraints(constraintsCollection)
        
        addConstraints([
            layoutBackTop,
            layoutBackHeight,
            layoutBackLeft,
            layoutBackWidth,
            layoutNextTop,
            layoutNextHeight,
            layoutNextRight,
            layoutNextWidth,
            layoutTitleTop,
            layoutTitleHeight,
            layoutTitleLeft,
            layoutTitleRight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: actions
    
    func actionBack(sender button:UIButton)
    {
        controller?.back()
    }
    
    func actionNext(sender button:UIButton)
    {
        
    }
    
    //MARK: collectionView delegate
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        return 0
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let cell:VCameraFilterBlenderCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VCameraFilterBlenderCell.reusableIdentifier,
            for:indexPath) as! VCameraFilterBlenderCell
        
        return cell
    }
}
