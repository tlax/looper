import Foundation

class MHelpCamera:MHelp
{
    init()
    {
        let itemCapture:MHelpItemCameraCapture = MHelpItemCameraCapture()
        let itemEdit:MHelpItemCameraEdit = MHelpItemCameraEdit()
        let itemOptions:MHelpItemCameraOptions = MHelpItemCameraOptions()
        let itemActive:MHelpItemCameraActive = MHelpItemCameraActive()
        let itemDeactive:MHelpItemCameraDeactive = MHelpItemCameraDeactive()
        let itemMore:MHelpItemCameraMore = MHelpItemCameraMore()
        let itemReady:MHelpItemCameraReady = MHelpItemCameraReady()
        
        let items:[MHelpItem] = [
            itemCapture,
            itemEdit,
            itemOptions,
            itemActive,
            itemDeactive,
            itemMore,
            itemReady
        ]
        
        super.init(items:items)
    }
}
