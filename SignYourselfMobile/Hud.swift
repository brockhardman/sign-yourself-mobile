

import UIKit



/// Hud is an overlay view that is placed on top to signify an action is taking place. You are able to display any type of view in the hud. If the content is larger then the Hud it will shrink it down to fit in the Hud. Keep this in mind when creating a content view for the Hud. It will always default to a `SpinnerView` if no content view is provied.
open class Hud {
    
    /// Checks if Hud is Visible
    public var isVisible: Bool = false
    
    /// Color of the Hud Defaults to white with an alpha level of 0.2
    public var hudColor = UIColor.white.withAlphaComponent(0.2)
    
    /// Singleton
    public static let `default`: Hud = Hud()
    
    public lazy var hudView: UIView = {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.layer.cornerRadius = 10
        view.clipsToBounds = true

        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
        return view
    }()
    
    public var hudContent: UIView?
    public var overlayView: UIView = UIView(frame: UIScreen.main.bounds)

    
    /// Can Display any type of content in the center of the Hud
    ///
    /// - Parameter content: Defaults to a SpinnerView 
    
    open func show(with content: UIView = SpinnerView()) {
        
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
    
    open func show(with content: UIView = SpinnerView(), over view: UIView) {
        guard !isVisible  else {
            return
        }
        
        overlayView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        
        isVisible = true
        hudView.backgroundColor = hudColor
        overlayView.addSubview(hudView)
        overlayView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        var hudCenter: CGPoint = CGPoint.zero
        
        view.addSubview(overlayView)
        hudCenter = view.center
        hudCenter.x -= view.frame.origin.x
        hudCenter.y -= view.frame.origin.y
        
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
    
    open func dismiss() {
        
        guard isVisible else {
            return
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.overlayView.alpha = 0.0
        }) { _ in
            self.isVisible = false
            self.hudView.removeFromSuperview()
            self.hudContent?.removeFromSuperview()
            self.hudContent = nil
            self.overlayView.removeFromSuperview()
        }
    }
}

public func >(lhs: CGSize, rhs: CGSize) -> Bool {
    return lhs.width > rhs.width || lhs.height > rhs.height
}
