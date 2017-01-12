import UIKit

class VCameraMore:VView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private weak var controller:CCameraMore!
    private weak var collectionView:VCollection!
    private weak var layoutCollectionBottom:NSLayoutConstraint!
    private var closeable:Bool
    private let kCollectionHeight:CGFloat = 400
    private let kAnimationDuration:TimeInterval = 0.3
    
    override init(controller:CController)
    {
        closeable = true
        
        super.init(controller:controller)
        backgroundColor = UIColor.clear
        self.controller = controller as? CCameraMore
        
        let blur:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.light)
        let visualEffect:UIVisualEffectView = UIVisualEffectView(effect:blur)
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        visualEffect.isUserInteractionEnabled = false
        visualEffect.clipsToBounds = true
        
        let closeButton:UIButton = UIButton()
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.backgroundColor = UIColor.clear
        closeButton.addTarget(
            self,
            action:#selector(actionClose(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let collectionView:VCollection = VCollection()
        collectionView.bounces = false
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(cell: <#T##UICollectionViewCell.Type#>)
        self.collectionView = collectionView
        
        addSubview(visualEffect)
        addSubview(closeButton)
        addSubview(collectionView)
        
        let constraintsEffect:[NSLayoutConstraint] = NSLayoutConstraint.equals(
            view:visualEffect,
            toView:self)
        let constraintsClose:[NSLayoutConstraint] = NSLayoutConstraint.equals(
            view:closeButton,
            toView:self)
        
        layoutCollectionBottom = NSLayoutConstraint.bottomToBottom(
            view:collectionView,
            toView:self,
            constant:kCollectionHeight)
        let layoutCollectionHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:collectionView,
            constant:kCollectionHeight)
        let layoutCollectionLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:collectionView,
            toView:self)
        let layoutCollectionRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:collectionView,
            toView:self)
        
        addConstraints(constraintsEffect)
        addConstraints(constraintsClose)
        
        addConstraints([
            layoutCollectionBottom,
            layoutCollectionHeight,
            layoutCollectionLeft,
            layoutCollectionRight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: actions
    
    func actionClose(sender button:UIButton)
    {
        if closeable
        {
            close()
        }
    }
    
    //MARK: public
    
    func close()
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
            
            self?.controller.close()
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
}
