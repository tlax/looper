import UIKit

class VCameraPreviewDisplay:UIView
{
    weak var imageView:UIImageView!
    
    init()
    {
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.genericBackground
        translatesAutoresizingMaskIntoConstraints = false
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        self.imageView = imageView
        
        let border:VBorder = VBorder(color:UIColor.black)
        
        addSubview(imageView)
        addSubview(border)
        
        NSLayoutConstraint.equals(
            view:imageView,
            toView:self)
        
        NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
        NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        NSLayoutConstraint.height(
            view:border,
            constant:1)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    deinit
    {
        imageView.stopAnimating()
    }
    
    //MARK: public
    
    func load(record:MCameraRecord)
    {
        var images:[UIImage] = []
        
        for item:MCameraRecordItem in record.items
        {
            images.append(item.image)
        }
        
        imageView.animationImages = images
        imageView.image = record.items.first?.image
    }
}
