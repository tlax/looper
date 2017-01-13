import UIKit

class MCameraMoreItemInfoFrames:MCameraMoreItemInfo
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
        
        let titleFrames:String = NSLocalizedString("MCameraMoreItemInfoFrames_titleFrames", comment:"")
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
            string:titleFrames,
            attributes:attributesTitle)
        let stringFrames:NSAttributedString = NSAttributedString(
            string:countString,
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
