import UIKit

class VCameraCellItem:UICollectionViewCell
{
    private weak var model:MCameraRecordItem?
    private weak var blur:VBlur!
    private weak var imageView:UIImageView!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView = imageView
        
        let blur:VBlur = VBlur.light()
        self.blur = blur
        
        addSubview(imageView)
        addSubview(blur)
        
        let constraintsImage:[NSLayoutConstraint] = NSLayoutConstraint.equals(
            view:imageView,
            toView:self)
        
        let constraintsBlur:[NSLayoutConstraint] = NSLayoutConstraint.equals(
            view:blur,
            toView:self)
        
        addConstraints(constraintsImage)
        addConstraints(constraintsBlur)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func config(model:MCameraRecordItem)
    {
        self.model = model
        imageView.image = model.image
        update()
    }
    
    func update()
    {
        guard
        
            let model:MCameraRecordItem = self.model
        
        else
        {
            return
        }
        
        if model.active
        {
            blur.isHidden = true
        }
        else
        {
            blur.isHidden = false
        }
    }
}
