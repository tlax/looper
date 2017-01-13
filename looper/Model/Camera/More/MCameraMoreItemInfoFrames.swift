import UIKit

class MCameraMoreItemInfoFrames:MCameraMoreItemInfo
{
    private let kTitleSize:CGFloat = 16
    private let kSubtitleSize:CGFloat = 15
    
    override init(record:MCameraRecord)
    {
        let attributedString:NSMutableAttributedString = NSMutableAttributedString()
        let attributesTitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.medium(size:kTitleSize),
            NSForegroundColorAttributeName:UIColor(white:0.2, alpha:1)]
        let attributesSubtitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.regular(size:kSubtitleSize),
            NSForegroundColorAttributeName:UIColor(white:0.3, alpha:1)]
        
        let titleFrames:String = NSLocalizedString("MCameraMoreItemInfoFrames_titleFrames", comment:"")
        let titleActive:String = NSLocalizedString("MCameraMoreItemInfoFrames_titleActive", comment:"")
        let countFrames:Int = record.items.count
        let countFramesString:String = "\(countFrames)"
        var countActive:Int = 0
        
        for item:MCameraRecordItem in record.items
        {
            if item.active
            {
                countActive += 1
            }
        }
        
        let countActiveString:String = "\(countActive)"
        let stringTitleFrames:NSAttributedString = NSAttributedString(
            string:titleFrames,
            attributes:attributesTitle)
        let stringFrames:NSAttributedString = NSAttributedString(
            string:countFramesString,
            attributes:attributesSubtitle)
        let stringTitleActive:NSAttributedString = NSAttributedString(
            string:titleActive,
            attributes:attributesTitle)
        let stringActive:NSAttributedString = NSAttributedString(
            string:countActiveString,
            attributes:attributesSubtitle)
        
        attributedString.append(stringTitleFrames)
        attributedString.append(stringFrames)
        attributedString.append(stringTitleActive)
        attributedString.append(stringActive)
        
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
