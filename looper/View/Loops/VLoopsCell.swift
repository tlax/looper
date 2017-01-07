import UIKit

class VLoopsCell:UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    private let modelOptions:MLoopsOptions
    private weak var model:MLoopsItem?
    private weak var controller:CLoops?
    private weak var collectionView:VCollection!
    private weak var imageView:UIImageView!
    private weak var spinner:VSpinner!
    private weak var button:UIButton!
    private weak var label:UILabel!
    private let numberFormatter:NumberFormatter
    private let kLabelFormat:String = "%@ s   -   %@ kb"
    private let kBackgroundMargin:CGFloat = 1
    private let kDeselect:TimeInterval = 0.2
    private let kPlaySize:CGFloat = 60
    private let kLabelRight:CGFloat = -10
    private let kLabelBottom:CGFloat = -16
    private let kMinInteger:Int = 1
    private let kMaxFraction:Int = 0
    
    override init(frame:CGRect)
    {
        modelOptions = MLoopsOptions()
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.minimumIntegerDigits = kMinInteger
        numberFormatter.maximumFractionDigits = kMaxFraction
        
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let countOptions:CGFloat = CGFloat(modelOptions.items.count)
        let width:CGFloat = frame.size.width
        let height:CGFloat = frame.size.height
        let playMarginTop:CGFloat = width - kPlaySize
        let playMarginRight:CGFloat = width - kPlaySize
        let backgroundHeight:CGFloat = width + kBackgroundMargin + kBackgroundMargin
        let collectionHeight:CGFloat = height - backgroundHeight
        let cellsWidth:CGFloat = collectionHeight * countOptions
        let marginRight:CGFloat = width - cellsWidth
        
        let button:UIButton = UIButton()
        button.backgroundColor = UIColor.clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.imageView!.contentMode = UIViewContentMode.center
        button.imageView!.clipsToBounds = true
        button.imageEdgeInsets = UIEdgeInsets(
            top:playMarginTop,
            left:0,
            bottom:0,
            right:playMarginRight)
        button.addTarget(
            self,
            action:#selector(actionButton(sender:)),
            for:UIControlEvents.touchUpInside)
        self.button = button
        
        let collectionView:VCollection = VCollection()
        collectionView.flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        collectionView.flow.itemSize = CGSize(
            width:collectionHeight,
            height:collectionHeight)
        collectionView.flow.sectionInset = UIEdgeInsets(
            top:0,
            left:0,
            bottom:0,
            right:marginRight)
        collectionView.isScrollEnabled = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(
            cell:VLoopsCellOption.self)
        self.collectionView = collectionView
        
        let background:UIView = UIView()
        background.clipsToBounds = true
        background.translatesAutoresizingMaskIntoConstraints = false
        background.isUserInteractionEnabled = false
        background.backgroundColor = UIColor(white:0, alpha:0.1)
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView = imageView
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.textAlignment = NSTextAlignment.right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.regular(size:12)
        label.textColor = UIColor(white:0.2, alpha:1)
        self.label = label
        
        let spinner:VSpinner = VSpinner()
        spinner.stopAnimating()
        self.spinner = spinner
        
        addSubview(background)
        addSubview(spinner)
        addSubview(imageView)
        addSubview(label)
        addSubview(button)
        addSubview(collectionView)
        
        let layoutImageTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:imageView,
            toView:background,
            constant:kBackgroundMargin)
        let layoutImageBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:imageView,
            toView:background,
            constant:-kBackgroundMargin)
        let layoutImageLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:imageView,
            toView:background)
        let layoutImageRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:imageView,
            toView:background)
        
        let layoutBackgroundTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:background,
            toView:self)
        let layoutBackgroundHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:background,
            constant:backgroundHeight)
        let layoutBackgroundLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:background,
            toView:self)
        let layoutBackgroundRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:background,
            toView:self)
        
        let layoutCollectionTop:NSLayoutConstraint = NSLayoutConstraint.topToBottom(
            view:collectionView,
            toView:background)
        let layoutCollectionBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:collectionView,
            toView:self)
        let layoutCollectionLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:collectionView,
            toView:self)
        let layoutCollectionRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:collectionView,
            toView:self)
        
        let layoutLabelTop:NSLayoutConstraint = NSLayoutConstraint.topToTop(
            view:label,
            toView:collectionView)
        let layoutLabelBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:label,
            toView:collectionView,
            constant:kLabelBottom)
        let layoutLabelLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:label,
            toView:self)
        let layoutLabelRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:label,
            toView:self,
            constant:kLabelRight)
        
        let constraintsButton:[NSLayoutConstraint] = NSLayoutConstraint.equals(
            view:button,
            parent:imageView)
        let constraintsSpinner:[NSLayoutConstraint] = NSLayoutConstraint.equals(
            view:spinner,
            parent:imageView)
        
        addConstraints(constraintsButton)
        addConstraints(constraintsSpinner)
        
        addConstraints([
            layoutImageTop,
            layoutImageBottom,
            layoutImageLeft,
            layoutImageRight,
            layoutBackgroundTop,
            layoutBackgroundHeight,
            layoutBackgroundLeft,
            layoutBackgroundRight,
            layoutCollectionTop,
            layoutCollectionBottom,
            layoutCollectionLeft,
            layoutCollectionRight,
            layoutLabelTop,
            layoutLabelBottom,
            layoutLabelLeft,
            layoutLabelRight])
        
        buttonPlay()
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(notifiedStopLoop(sender:)),
            name:Notification.loopsPause,
            object:nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
        spinner.stopAnimating()
        imageView.stopAnimating()
    }
    
    //MARK: notifications
    
    func notifiedStopLoop(sender notification:Notification)
    {
        if imageView.isAnimating
        {
            stopLoop()
        }
    }
    
    //MARK: actions
    
    func actionButton(sender button:UIButton)
    {
        button.isHidden = true
        
        if imageView.isAnimating
        {
            stopLoop()
        }
        else
        {
            startLoop()
        }
    }
    
    //MARK: private
    
    private func stopLoop()
    {
        spinner.stopAnimating()
        imageView.stopAnimating()
        imageView.isHidden = false
        imageView.animationImages = nil
        buttonPlay()
    }
    
    private func startLoop()
    {
        NotificationCenter.default.post(
            name:Notification.loopsPause,
            object:nil)
        
        imageView.isHidden = true
        spinner.startAnimating()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncStartLoop()
        }
    }
    
    private func asyncStartLoop()
    {
        let images:[UIImage]? = model?.images.imageLists()
        
        DispatchQueue.main.async
        { [weak self] in
        
            self?.loopReady(images:images)
        }
    }
    
    private func loopReady(images:[UIImage]?)
    {
        imageView.isHidden = false
        spinner.stopAnimating()
        imageView.animationImages = images
        imageView.startAnimating()
        buttonPause()
    }
    
    private func modelAtIndex(index:IndexPath) -> MLoopsOptionsItem
    {
        let item:MLoopsOptionsItem = modelOptions.items[index.item]
        
        return item
    }
    
    private func buttonPlay()
    {
        button.setImage(
            #imageLiteral(resourceName: "assetLoopsPlay"),
            for:UIControlState.normal)
        button.isHidden = false
    }
    
    private func buttonPause()
    {
        button.setImage(
            #imageLiteral(resourceName: "assetLoopsPause"),
            for:UIControlState.normal)
        button.isHidden = false
    }
    
    //MARK: public
    
    func config(model:MLoopsItem, controller:CLoops)
    {
        self.model = model
        self.controller = controller
        spinner.stopAnimating()
        imageView.stopAnimating()
        imageView.image = model.images.cover
        imageView.animationDuration = model.loop.duration
        imageView.animationImages = nil
        imageView.isHidden = false
        
        let numberDuration:NSNumber = model.loop.duration as NSNumber
        let numberKilobytes:NSNumber = model.loop.kiloBytes as NSNumber
        
        guard
        
            let stringDuration:String = numberFormatter.string(
                from:numberDuration),
            let stringKilobytes:String = numberFormatter.string(
                from:numberKilobytes)
        
        else
        {
            return
        }
        
        let compositeString:String = String(
            format:kLabelFormat,
            stringDuration,
            stringKilobytes)
        label.text = compositeString
    }
    
    //MARK: collectionView delegate
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = modelOptions.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MLoopsOptionsItem = modelAtIndex(index:indexPath)
        let cell:VLoopsCellOption = collectionView.dequeueReusableCell(
            withReuseIdentifier:
            VLoopsCellOption.reusableIdentifier,
            for:indexPath) as! VLoopsCellOption
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        NotificationCenter.default.post(
            name:Notification.loopsPause,
            object:nil)
        
        DispatchQueue.main.asyncAfter(
            deadline:DispatchTime.now() + kDeselect)
        { [weak collectionView] in
            
            collectionView?.selectItem(
                at:nil,
                animated:true,
                scrollPosition:UICollectionViewScrollPosition())
        }
        
        guard
            
            let controller:CLoops = self.controller,
            let model:MLoopsItem = self.model
        
        else
        {
            return
        }
        
        let item:MLoopsOptionsItem = modelAtIndex(index:indexPath)
        item.selected(
            controller:controller,
            model:model)
    }
}
