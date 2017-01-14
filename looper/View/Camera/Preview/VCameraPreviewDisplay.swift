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
        
        let constraintsImage:[NSLayoutConstraint] = NSLayoutConstraint.equals(
            view:imageView,
            toView:self)
        let constraintsBorderHorizontal:[NSLayoutConstraint] = NSLayoutConstraint.equalsHorizontal(
            view:border,
            toView:self)
        
        let layoutBorderBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        let layoutBorderHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:border,
            constant:1)
        
        addConstraints(constraintsImage)
        addConstraints(constraintsBorderHorizontal)
        
        addConstraints([
            layoutBorderBottom,
            layoutBorderHeight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
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
