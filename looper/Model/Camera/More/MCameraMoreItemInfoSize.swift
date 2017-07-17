import UIKit

class MCameraMoreItemInfoSize:MCameraMoreItemInfo
{
    private let kTitleSize:CGFloat = 16
    private let kSubtitleSize:CGFloat = 14
    
    init(record:MCameraRecord)
    {
        let attributedString:NSMutableAttributedString = NSMutableAttributedString()
        let attributesTitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bold(size:kTitleSize),
            NSForegroundColorAttributeName:UIColor.genericLight]
        let attributesSubtitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.medium(size:kSubtitleSize),
            NSForegroundColorAttributeName:UIColor.black]
        
        let title:String = NSLocalizedString("MCameraMoreItemInfoSize_title", comment:"")
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
            string:title,
            attributes:attributesTitle)
        let stringFrames:NSAttributedString = NSAttributedString(
            string:sizeString,
            attributes:attributesSubtitle)
        
        attributedString.append(stringTitleFrames)
        attributedString.append(stringFrames)
        
        super.init(attributedString:attributedString)
    }
}
