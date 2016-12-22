import UIKit

class VHomeControlBlenderPiecesItem:UIView
{
    private weak var imageView:UIImageView!
    private weak var model:MHomeImageSequenceItem!
    
    convenience init(model:MHomeImageSequenceItem)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
        self.model = model
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.image = model.image
        self.imageView = imageView
        addSubview(imageView)
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let cornerRadius:CGFloat = width / 2.0
        layer.cornerRadius = cornerRadius
        
        super.layoutSubviews()
    }
}
