import UIKit

class MCameraMoreItemInfoSpeed:MCameraMoreItemInfo
{
    private let kTitleSize:CGFloat = 12
    private let kSubtitleSize:CGFloat = 16
    
    override init(record:MCameraRecord)
    {
        let attributedString:NSMutableAttributedString = NSMutableAttributedString()
        let attributesTitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.medium(size:kTitleSize),
            NSForegroundColorAttributeName:UIColor.black]
        let attributesSubtitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.medium(size:kSubtitleSize),
            NSForegroundColorAttributeName:UIColor.genericLight]
        
        let titleFrames:String = NSLocalizedString("MCameraMoreItemInfoSize_titleFrames", comment:"")
        let itemSize:Int
        
        if let itemWidth:CGFloat = record.items.first?.image.size.width
        {
            itemSize = Int(itemWidth)
        }
        else
        {
            itemSize = 0
        }
        
        let sizeString:String = "\(itemSize)x\(itemSize)"
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
