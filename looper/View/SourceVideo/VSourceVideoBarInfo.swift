import UIKit

class VSourceVideoBarInfo:View<VSourceVideo, MSourceVideo, CSourceVideo>
{
    private weak var viewCellWidth:VSourceVideoBarInfoCell!
    private weak var viewCellHeight:VSourceVideoBarInfoCell!
    private weak var viewCellDuration:VSourceVideoBarInfoCell!
    private let kCellHeight:CGFloat = 38
    private let kCellTop:CGFloat = 100
    private let kSecondsInMinute:TimeInterval = 60
    
    required init(controller:CSourceVideo)
    {
        super.init(controller:controller)
        
        let viewCellWidth:VSourceVideoBarInfoCell = VSourceVideoBarInfoCell(controller:controller)
        viewCellWidth.changeTitle(title:String.localizedView(key:"VSourceVideoBarInfo_titleWidth"))
        self.viewCellWidth = viewCellWidth
        
        let viewCellHeight:VSourceVideoBarInfoCell = VSourceVideoBarInfoCell(controller:controller)
        viewCellHeight.changeTitle(title:String.localizedView(key:"VSourceVideoBarInfo_titleHeight"))
        self.viewCellHeight = viewCellHeight
        
        let viewCellDuration:VSourceVideoBarInfoCell = VSourceVideoBarInfoCell(controller:controller)
        viewCellDuration.changeTitle(title:String.localizedView(key:"VSourceVideoBarInfo_titleDuration"))
        self.viewCellDuration = viewCellDuration
        
        addSubview(viewCellWidth)
        addSubview(viewCellHeight)
        addSubview(viewCellDuration)
        
        NSLayoutConstraint.topToTop(
            view:viewCellWidth,
            toView:self,
            constant:kCellTop)
        NSLayoutConstraint.height(
            view:viewCellWidth,
            constant:kCellHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewCellWidth,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:viewCellHeight,
            toView:viewCellWidth)
        NSLayoutConstraint.height(
            view:viewCellHeight,
            constant:kCellHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewCellHeight,
            toView:self)
        
        NSLayoutConstraint.topToBottom(
            view:viewCellDuration,
            toView:viewCellHeight)
        NSLayoutConstraint.height(
            view:viewCellDuration,
            constant:kCellHeight)
        NSLayoutConstraint.equalsHorizontal(
            view:viewCellDuration,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: private
    
    private func durationFrom(duration:TimeInterval) -> String
    {
        let minutes:Int = Int(duration / kSecondsInMinute)
        let seconds:Int = Int(duration.truncatingRemainder(dividingBy:kSecondsInMinute))
        var string:String
        
        if minutes > 9
        {
            string = "\(minutes)"
        }
        else
        {
            string = "0\(minutes)"
        }
        
        string = "\(string):"
        
        if seconds < 10
        {
            string = "\(string)0"
        }
        
        string = "\(string)\(seconds)"
        
        return string
    }
    
    //MARK: public
    
    func config(model:MSourceVideoItem)
    {
        let width:String = "\(model.asset.pixelWidth) px"
        let height:String = "\(model.asset.pixelHeight) px"
        let duration:String = durationFrom(duration:model.asset.duration)
        
        viewCellWidth.changeValue(value:width)
        viewCellHeight.changeValue(value:height)
        viewCellDuration.changeValue(value:duration)
    }
}
