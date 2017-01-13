import UIKit

class MCameraMoreItemInfoSpeed:MCameraMoreItemInfo
{
    private let kTitleSize:CGFloat = 12
    private let kSubtitleSize:CGFloat = 16
    
    override init(record:MCameraRecordEditable)
    {
        let attributedString:NSMutableAttributedString = NSMutableAttributedString()
        let attributesTitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.bold(size:kTitleSize),
            NSForegroundColorAttributeName:UIColor.genericLight]
        let attributesSubtitle:[String:AnyObject] = [
            NSFontAttributeName:UIFont.medium(size:kSubtitleSize),
            NSForegroundColorAttributeName:UIColor.black]
        
        let title:String = NSLocalizedString("MCameraMoreItemInfoSpeed_title", comment:"")
        let speedString:String = record.speed.name
        let stringTitleFrames:NSAttributedString = NSAttributedString(
            string:title,
            attributes:attributesTitle)
        let stringFrames:NSAttributedString = NSAttributedString(
            string:speedString,
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
