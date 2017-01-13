import UIKit

class MCameraMoreItemInfoSize:MCameraMoreItemInfo
{
    private let kTitleSize:CGFloat = 13
    private let kSubtitleSize:CGFloat = 18
    
    override init(record:MCameraRecord)
    {
        let attributedString:NSMutableAttributedString = NSMutableAttributedString()
        let attributesTitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.medium(size:kTitleSize),
            NSForegroundColorAttributeName:UIColor.black]
        let attributesSubtitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:kSubtitleSize),
            NSForegroundColorAttributeName:UIColor(white:0.4, alpha:1)]
        
        let titleFrames:String = NSLocalizedString("MCameraMoreItemInfoSize_titleFrames", comment:"")
        let itemSize:CGFloat
        
        if let itemWidth:CGFloat = record.items.first?.image.size.width
        {
            itemSize = itemWidth
        }
        else
        {
            itemSize = 0
        }
        
        let sizeString:String = "\(itemSize)/\(itemSize)"
        let stringTitleFrames:NSAttributedString = NSAttributedString(
            string:titleFrames,
            attributes:attributesTitle)
        let stringFrames:NSAttributedString = NSAttributedString(
            string:sizeString,
            attributes:attributesSubtitle)
        
        attributedString.append(stringTitleFrames)
        attributedString.append(stringFrames)
        
        super.init(attributedString:attributedString)
    }
    
    override init(attributedString:NSAttributedString)
    {
        fatalError()
    }
    
    override init(reusableIdentifier:String, cellHeight:CGFloat)
    {
        fatalError()
    }
}
