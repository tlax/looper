import Foundation

class MCameraSpeed
{
    let timeInterval:TimeInterval
    let name:String
    
    class func all() -> [MCameraSpeed]
    {
        let item30:MCameraSpeed30 = MCameraSpeed30()
        let item20:MCameraSpeed20 = MCameraSpeed20()
        let item15:MCameraSpeed15 = MCameraSpeed15()
        let item10:MCameraSpeed10 = MCameraSpeed10()
        let item5:MCameraSpeed5 = MCameraSpeed5()
        let item3:MCameraSpeed3 = MCameraSpeed3()
        let item2:MCameraSpeed2 = MCameraSpeed2()
        let item1:MCameraSpeed1 = MCameraSpeed1()
        let itemHalf:MCameraSpeedHalf = MCameraSpeedHalf()
        
        let model:[MCameraSpeed] = [
            item30,
            item20,
            item15,
            item10,
            item5,
            item3,
            item2,
            item1,
            itemHalf
        ]
        
        return model
    }
    
    init(framesPerSecond:TimeInterval)
    {
        timeInterval = 1 / framesPerSecond
        
        if framesPerSecond >= 1
        {
            name = "\(Int(framesPerSecond))"
        }
        else
        {
            name = "\(framesPerSecond)"
        }
    }
}
