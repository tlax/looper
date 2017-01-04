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
        
        let border:UIView = UIView()
        border.isUserInteractionEnabled = false
        border.translatesAutoresizingMaskIntoConstraints = false
        border.clipsToBounds = true
        border.backgroundColor = UIColor.black
        
        addSubview(imageView)
        addSubview(border)
        
        let constraintsImage:[NSLayoutConstraint] = NSLayoutConstraint.equals(
            view:imageView,
            parent:self)
        
        let layoutBorderBottom:NSLayoutConstraint = NSLayoutConstraint.bottomToBottom(
            view:border,
            toView:self)
        let layoutBorderHeight:NSLayoutConstraint = NSLayoutConstraint.height(
            view:border,
            constant:1)
        let layoutBorderLeft:NSLayoutConstraint = NSLayoutConstraint.leftToLeft(
            view:border,
            toView:self)
        let layoutBorderRight:NSLayoutConstraint = NSLayoutConstraint.rightToRight(
            view:border,
            toView:self)
        
        addConstraints(constraintsImage)
        
        addConstraints([
            layoutBorderBottom,
            layoutBorderHeight,
            layoutBorderLeft,
            layoutBorderRight])
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
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
