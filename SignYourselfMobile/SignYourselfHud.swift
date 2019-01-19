

public class SignYourselfHud: Hud {

    public override func show(with content: UIView) {
        guard !isVisible  else {
            return
        }
        
        isVisible = true
        hudView.backgroundColor = hudColor
        overlayView.addSubview(hudView)
        overlayView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        var hudCenter: CGPoint = CGPoint.zero
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while (topController.presentedViewController != nil) {
                topController = topController.presentedViewController!
            }
            
            topController.view.addSubview(overlayView)
            hudCenter = topController.view.center
        }

        hudView.center = hudCenter
        hudContent = content
        hudContent?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        if content.frame.size > hudView.frame.size {
            hudContent?.frame = hudView.bounds
        }
        
        hudContent?.center = hudCenter
        overlayView.addSubview(hudContent!)
        UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.overlayView.alpha = 1
        }, completion: nil)

    }
}
