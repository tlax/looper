import Foundation

extension String
{
    private static let tableReformaCrossing:String = "ReformaCrossing"
    private static let tablePollutedGarden:String = "PollutedGarden"
    private static let tableWhistlesVsZombies:String = "WhistlesVsZombies"
    private static let tableTalamesOaxaquenos:String = "TamalesOaxaquenos"
    
    static func localized(key:String) -> String
    {
        return NSLocalizedString(key, comment:"")
    }
    
    static func localizedReformaCrossing(key:String) -> String
    {
        return NSLocalizedString(key, tableName:tableReformaCrossing, comment:"")
    }
    
    static func localizedPollutedGarden(key:String) -> String
    {
        return NSLocalizedString(key, tableName:tablePollutedGarden, comment:"")
    }
    
    static func localizedWhistlesVsZombies(key:String) -> String
    {
        return NSLocalizedString(key, tableName:tableWhistlesVsZombies, comment:"")
    }
    
    static func localizedTamalesOaxaquenos(key:String) -> String
    {
        return NSLocalizedString(key, tableName:tableTalamesOaxaquenos, comment:"")
    }
    
    func capitalizedFirstLetter() -> String
    {
        let count:Int = characters.count
        
        if count < 1
        {
            return self
        }
        else if count == 1
        {
            return uppercased()
        }
        
        let firstLetter:String = String(self[startIndex]).uppercased()
        let remainRange:Range = Range(uncheckedBounds:(
            lower:index(startIndex, offsetBy:1),
            upper:index(startIndex, offsetBy:count)))
        let remain:String = self[remainRange].lowercased()
        let newString:String = "\(firstLetter)\(remain)"
        
        return newString
    }
}
