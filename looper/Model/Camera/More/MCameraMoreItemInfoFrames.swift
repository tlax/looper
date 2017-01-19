import UIKit

class MCameraMoreItemInfoFrames:MCameraMoreItemInfo
{
    private let kTitleSize:CGFloat = 16
    private let kSubtitleSize:CGFloat = 14
    
    init(record:MCameraRecordEditable)
    {
        let attributedString:NSMutableAttributedString = NSMutableAttributedString()
        let attributesTitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bold(size:kTitleSize),
            NSForegroundColorAttributeName:UIColor.genericLight]
        let attributesSubtitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.medium(size:kSubtitleSize),
            NSForegroundColorAttributeName:UIColor.black]
        
        let title:String = NSLocalizedString("MCameraMoreItemInfoFrames_title", comment:"")
        let countFrames:Int = record.items.count
        var countActive:Int = 0
        
        for item:MCameraRecordItem in record.items
        {
            if item.active
            {
                countActive += 1
            }
        }
        
        let countString:String = "\(countActive)/\(countFrames)"
        let stringTitleFrames:NSAttributedString = NSAttributedString(
            string:title,
            attributes:attributesTitle)
        let stringFrames:NSAttributedString = NSAttributedString(
            string:countString,
            attributes:attributesSubtitle)
        
        attributedString.append(stringTitleFrames)
        attributedString.append(stringFrames)
        
        super.init(attributedString:attributedString)
    }
}
