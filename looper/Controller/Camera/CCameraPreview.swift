import UIKit

class CCameraPreview:CController
{
    let model:MCameraRecord
    
    init(model:MCameraRecord)
    {
        self.model = model
        super.init()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
