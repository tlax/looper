import UIKit

class VEditDurationDisplay:
    View<VEditDuration, MEditDuration, CEditDuration>
{
    private weak var label:UILabel!
    
    required init(controller:CEditDuration)
    {
        super.init(controller:controller)
        isUserInteractionEnabled = false
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.light(size:60)
        label.textColor = UIColor.colourBackgroundDark
        self.label = label
        
        addSubview(label)
        
        NSLayoutConstraint.equals(
            view:label,
            toView:self)
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    //MARK: public
    
    func update()
    {
        let minutes:Int = controller.model.currentMinute().value
        let seconds:Int = controller.model.currentSecond().value
        var string:String
        
        if minutes < 10
        {
            string = "0"
        }
        else
        {
            string = ""
        }
        
        string = "\(string)\(minutes):"
        
        if seconds < 10
        {
            string = "\(string)0"
        }
        
        string = "\(string)\(seconds)"
        
        label.text = string
    }
}
