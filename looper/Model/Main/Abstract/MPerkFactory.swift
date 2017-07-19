import Foundation

class MPerkFactory
{
    class func factoryPerks() -> [MPerkProtocol]
    {
        let perkReformaCrossing:MPerkReformaCrossing = MPerkReformaCrossing()
        let perkPollutedGarden:MPerkPollutedGarden = MPerkPollutedGarden()
        let perkWhistlesVsZombies:MPerkWhistlesVsZombies = MPerkWhistlesVsZombies()
        let perkTamalesOaxaquenos:MPerkTamalesOaxaquenos = MPerkTamalesOaxaquenos()
        
        let perks:[MPerkProtocol] = [
            perkReformaCrossing,
            perkPollutedGarden,
            perkWhistlesVsZombies,
            perkTamalesOaxaquenos]
        
        return perks
    }
}
