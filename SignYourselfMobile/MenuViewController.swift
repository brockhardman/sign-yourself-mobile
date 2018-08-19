

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet var menuLeftConstraint: NSLayoutConstraint!
    @IBOutlet var blackBackgroundView: UIView!
    @IBOutlet var viewMenuContainer: UIView!
    @IBOutlet var menuWidthConstraint: NSLayoutConstraint!
    
    let maxBlackViewAlpha: CGFloat = 0.5
    let animationDuration: TimeInterval = 0.3
    var isOpen: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideMenu()
    }
    
    @IBAction func gesturePan(_ sender: UIPanGestureRecognizer) {
        
        // retrieve the current state of the gesture
        if sender.state == UIGestureRecognizerState.began {
            
            // no need to do anything
        } else if sender.state == UIGestureRecognizerState.changed {
            
            // retrieve the amount viewMenu has been dragged
            let translationX = sender.translation(in: sender.view).x
            
            if translationX > 0 {
                
                // viewMenu fully dragged out
                menuLeftConstraint.constant = 0
                blackBackgroundView.alpha = maxBlackViewAlpha
                
            } else if translationX < -menuWidthConstraint.constant {
                
                // viewMenu fully dragged in
                menuLeftConstraint.constant = -menuWidthConstraint.constant
                blackBackgroundView.alpha = 0
                
            } else {
                
                // it's being dragged somewhere between min and max amount
                menuLeftConstraint.constant = translationX
                
                let ratio = (menuWidthConstraint.constant + translationX) / menuWidthConstraint.constant
                let alphaValue = ratio * maxBlackViewAlpha
                blackBackgroundView.alpha = alphaValue
            }
        } else {
            
            // if the drag was less than half of it's width, close it. Otherwise, open it.
            if menuLeftConstraint.constant < -menuWidthConstraint.constant / 2 {
                self.hideMenu()
            } else {
                self.openMenu()
            }
        }
    }
    
    @IBAction func gestureTap(_ sender: UITapGestureRecognizer) {
        if isOpen {
            hideMenu()
        }
    }
    
    func openMenu() {
        
        if isOpen {
            hideMenu()
            return
        }
        
        self.view.isHidden = false

        // when menu is opened, it's left constraint should be 0
        menuLeftConstraint.constant = 0
    
        // view for dimming effect should also be shown
        blackBackgroundView.isHidden = false
        
        // animate opening of the menu - including opacity value
        UIView.animate(withDuration: animationDuration, animations: {
            self.view.layoutIfNeeded()
            self.blackBackgroundView.alpha = self.maxBlackViewAlpha
        }, completion: { (complete) in
            // disable the screen edge pan gesture when menu is fully opened
            self.isOpen = true
        })
    }
    
    func hideMenu() {
        
        // when menu is closed, it's left constraint should be of value that allows it to be completely hidden to the left of the screen - which is negative value of it's width
        menuLeftConstraint.constant = -menuWidthConstraint.constant
        
        // animate closing of the menu - including opacity value
        UIView.animate(withDuration: animationDuration, animations: {
            
            self.view.layoutIfNeeded()
            self.blackBackgroundView.alpha = 0
            
        }, completion: { (complete) in
            
            // reenable the screen edge pan gesture so we can detect it next time
            self.isOpen = false
            
            // hide the view for dimming effect so it wont interrupt touches for views underneath it
            self.blackBackgroundView.isHidden = true
            self.view.isHidden = true
        })
    }
}

extension MenuViewController : RootViewControllerScreenEdgeProtocol {
    
    func screenEdgeDidPan(_ sender: UIScreenEdgePanGestureRecognizer) {
        
        self.view.isHidden = false
        
        if isOpen {return}
        
        // retrieve the current state of the gesture
        if sender.state == UIGestureRecognizerState.began {
            
            // if the user has just started dragging, make sure view for dimming effect is hidden well
            blackBackgroundView.isHidden = false
            blackBackgroundView.alpha = 0
            
        } else if (sender.state == UIGestureRecognizerState.changed) {
            
            // retrieve the amount viewMenu has been dragged
            let translationX = sender.translation(in: sender.view).x
            
            if -menuWidthConstraint.constant + translationX > 0 {
                
                // viewMenu fully dragged out
                menuLeftConstraint.constant = 0
                blackBackgroundView.alpha = maxBlackViewAlpha
                
            } else if translationX < 0 {
                
                // viewMenu fully dragged in
                menuLeftConstraint.constant = -menuWidthConstraint.constant
                blackBackgroundView.alpha = 0
                
            } else {
                
                // viewMenu is being dragged somewhere between min and max amount
                menuLeftConstraint.constant = -menuWidthConstraint.constant + translationX
                
                let ratio = translationX / menuWidthConstraint.constant
                let alphaValue = ratio * maxBlackViewAlpha
                blackBackgroundView.alpha = alphaValue
            }
        } else {
            
            // if the menu was dragged less than half of it's width, close it. Otherwise, open it.
            if menuLeftConstraint.constant < -menuWidthConstraint.constant / 2 {
                hideMenu()
            } else {
                openMenu()
            }
        }
    }
}
