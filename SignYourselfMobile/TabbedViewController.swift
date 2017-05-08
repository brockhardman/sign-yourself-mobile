//
//  TabbedViewController.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 5/7/17.
//  Copyright © 2017 SignYourself. All rights reserved.
//

class TabbedViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    var mainPinchGestureMaxScale:CGFloat = 1.0
    var mainPinchGestureMinScale:CGFloat = 0.5
    var activeControllers = NSArray()
    var activeControllersObjects = Array<ActiveViewController>()
    var tapGestures = NSMutableArray()
    var isZoomed = true;
    var currentControllerIndex = 0;
    @IBOutlet weak var visualEffectsView:UIVisualEffectView?;
    @IBOutlet weak var scrollView:UIScrollView?;
    @IBOutlet weak var bottomNavView:UIView?;
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let activeControllerService = ActiveControllerService();
        activeControllerService.configureWithURL(url: "", completionBlock: {controllers in
            self.activeControllers = controllers as NSArray
            DispatchQueue.main.async {
                self.buildScrollViewWithActiveControllers()
                self.buildBottomNavWithActiveControllers()
            };
        })
        
        let pinchGesture : UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action:#selector(userDidPinch(pinch:)))
        self.scrollView?.addGestureRecognizer(pinchGesture)
        self.scrollView?.delegate = self;
    }
    
    func trackScreenInfoForIndex(index:NSInteger, didUseNavButton:Bool) {
        let screenTitle : String = (self.activeControllers.object(at: index) as! NSDictionary).object(forKey: "navTitle") as! String
        let screenInfo : NSDictionary = ["scrolledToScreen" : screenTitle, "usedNavigationButton" : didUseNavButton]
        debugPrint(screenInfo)
        //        [[MParticle sharedInstance] logScreen:screenTitle eventInfo:screenInfo];
    }
    
    func userDidPinch(pinch:UIPinchGestureRecognizer) {
        let scaleToUse : CGFloat = getUpdatedScaleWithScale(scale: pinch.scale);
        
        if (pinch.state == UIGestureRecognizerState.changed)
        {
            updateControllersWithScale(scale: scaleToUse);
        }
        else if (pinch.state == UIGestureRecognizerState.ended)
        {
            let scaleLowerThreshold = (1.0 - ((self.mainPinchGestureMaxScale - self.mainPinchGestureMinScale) / 2.0));
            
            if (scaleToUse < scaleLowerThreshold)
            {
                setControllersToMinScaleWithDuration(timeInterval: 0.2);
            }
            else
            {
                setControllersToMaxScaleWithDuration(timeInterval: 0.2);
            }
        }
    }
    
    func buildScrollViewWithActiveControllers() {
        let screenBounds = UIScreen.main.bounds
        
        for index in 0...self.activeControllers.count-1 {
            let originX = CGFloat(index) * screenBounds.size.width;
            let height = screenBounds.size.height - (self.bottomNavView?.frame.size.height)!;
            let frame = CGRect(x:originX, y:screenBounds.origin.y, width:screenBounds.size.width, height:height);
            let backingView = UIView(frame: frame)
            self.scrollView?.addSubview(backingView)
            
            addActiveControllerToView(view: backingView, viewControllerDictionary:self.activeControllers.object(at: index) as! NSDictionary)
        }
        
        let contentWidth = screenBounds.size.width * CGFloat(self.activeControllers.count)
        self.scrollView?.contentSize = CGSize(width:contentWidth, height:self.scrollView!.frame.size.height);
    }
    
    func addActiveControllerToView(view:UIView, viewControllerDictionary:NSDictionary) {
        if (self.activeControllers.count > 0) {
            let navTitle = viewControllerDictionary.object(forKey: "navTitle")
            let navImage = viewControllerDictionary.object(forKey: "navImage")
            let viewControllerClassName = viewControllerDictionary.object(forKey: "viewControllerClassName")
            let storyboardName = viewControllerDictionary.object(forKey: "storyboardName")
            
            let activeController : ActiveViewController = UIStoryboard(name: storyboardName as! String, bundle:nil).instantiateViewController(withIdentifier: viewControllerClassName as! String) as! ActiveViewController
            
            activeController.configure(title:navTitle as! String, image:navImage as! String)
            self.addChildViewController(activeController)
            activeController.didMove(toParentViewController: self)
            view.addSubview(activeController.view)
            activeController.view.frame = view.bounds
            self.activeControllersObjects.append(activeController)
        }
    }
    
    func buildBottomNavWithActiveControllers() {
        let screenRect = UIScreen.main.bounds;
        let navButtonWidth = screenRect.size.width / CGFloat(self.activeControllers.count);
        
        for index in 0...self.activeControllers.count-1 {
            
            let beginX = CGFloat(index) * navButtonWidth;
            let navButtonView = UIView(frame: CGRect(x:beginX,y:0, width:navButtonWidth, height:(self.bottomNavView?.frame.size.height)!))
            navButtonView.backgroundColor = UIColor.clear
            
            let navButton = UIButton()
            navButton.frame = CGRect(x: 0, y: 0, width: navButtonWidth, height: (self.bottomNavView?.frame.size.height)!)
            navButton.tag = index
            navButton.addTarget(self, action: #selector(navButtonTapped), for: UIControlEvents.touchUpInside)
            let dict = self.activeControllers.object(at: index) as! NSDictionary
            navButton.setTitle(dict.object(forKey: "navTitle") as? String, for: UIControlState.normal)
            navButton.titleLabel?.textAlignment = NSTextAlignment.center;
            navButton.titleEdgeInsets = UIEdgeInsets(top:(self.bottomNavView?.frame.size.height)! - 18, left:0, bottom:0, right:0)
            navButton.titleLabel?.font = UIFont(name:"Helvetica", size:10)
            navButton.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
            navButtonView.addSubview(navButton)
            
            let buttonImageView = UIImageView(image:UIImage(named: (dict.object(forKey: "navImage") as? String)!))
            buttonImageView.center = CGPoint(x:navButtonWidth / 2, y:buttonImageView.frame.size.height / 2 + 3)
            buttonImageView.backgroundColor =  UIColor.clear
            navButtonView.addSubview(buttonImageView)
            
            self.bottomNavView?.addSubview(navButtonView)
        }
    }
    
    func setControllersToMinScaleWithDuration(timeInterval:TimeInterval) {
        
        for activeController : ActiveViewController in self.activeControllersObjects {
            activeController.view.clipsToBounds = false
            UIView.animate(withDuration: timeInterval, animations: {
                let transform = CGAffineTransform.init(scaleX: self.mainPinchGestureMinScale, y: self.mainPinchGestureMinScale)
                activeController.view.transform = transform;
                let floatingTitleView = UIView(frame:CGRect(x:activeController.view.bounds.origin.x, y:activeController.view.bounds.origin.y - 100, width:activeController.view.bounds.size.width, height:50))
                let titleLabel = UILabel(frame:floatingTitleView.bounds)
                titleLabel.textAlignment = NSTextAlignment.center
                titleLabel.text = activeController.navigationTitle.uppercased()
                titleLabel.font = UIFont(name: "Helvetica", size: 25)
                floatingTitleView.addSubview(titleLabel)
                activeController.view.addSubview(floatingTitleView)
            }, completion: { (didFinish) in
                if didFinish {
                    self.addShadowToView(view: activeController.view)
                }
            })
        }
        
        addTapGestureToView(view:self.scrollView!)
        self.isZoomed = true;
    }
    
    func setControllersToMaxScaleWithDuration(timeInterval:TimeInterval)
    {
        for activeController : ActiveViewController in self.activeControllersObjects {
            UIView.animate(withDuration: timeInterval, animations: {
                let transform = CGAffineTransform.init(scaleX: self.mainPinchGestureMaxScale, y: self.mainPinchGestureMaxScale)
                activeController.view.transform = transform;
            }, completion: { (didFinish) in
                if didFinish {
                    self.removeShadowFromView(view: activeController.view)
                    self.removeTapGestureFromView(view: activeController.view)
                    activeController.view.clipsToBounds = true
                }
            })
        }
        
        self.isZoomed = false
    }
    
    func addShadowToView(view:UIView) {
        let layer = view.layer
        layer.masksToBounds = false
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        layer.shadowRadius = 10.0
        layer.shadowOpacity = 0.5
        layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: layer.cornerRadius).cgPath
    }
    
    func removeShadowFromView(view:UIView) {
        let layer = view.layer
        layer.masksToBounds = true
        layer.shadowColor = nil
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 0.0
        layer.shadowOpacity = 0.0
        layer.shadowPath = nil
    }
    
    func addTapGestureToView(view:UIView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(userDidTap(tap:)))
        view.addGestureRecognizer(tapGesture)
        self.tapGestures.add(tapGesture)
    }
    
    func removeTapGestureFromView(view:UIView)
    {
        view.gestureRecognizers?.forEach({ recognizer in
            if self.tapGestures.contains(recognizer) {
                view.removeGestureRecognizer(recognizer)
                self.tapGestures.remove(recognizer)
            }
        })
    }
    
    func userDidTap(tap: UITapGestureRecognizer)
    {
        if (self.isZoomed) {
            setControllersToMaxScaleWithDuration(timeInterval: 0.2)
        }
    }
    
    func updateControllersWithScale(scale:CGFloat)
    {
        for activeController : ActiveViewController in self.activeControllersObjects {
            let transform = CGAffineTransform.init(scaleX: scale, y: scale)
            activeController.view.transform = transform;
        }
    }
    
    func getUpdatedScaleWithScale(scale:CGFloat) -> CGFloat {
        var passedScale = scale
        if (self.isZoomed) {
            passedScale = scale - self.mainPinchGestureMinScale;
        }
        
        //This check will keep the user from zooming past max scale as it causes weird behavior
        return min(passedScale, self.mainPinchGestureMaxScale);
    }
    
    func navButtonTapped(sender:UIButton) {
        if (self.currentControllerIndex != sender.tag) {
            let screenRect = UIScreen.main.bounds
            let newOffsetX = screenRect.size.width * CGFloat(sender.tag);
            
            if (!self.isZoomed) {
                self.setControllersToMinScaleWithDuration(timeInterval: 0.4)
            }
            UIView.animate(withDuration: 0.6, animations: {
                self.scrollView!.setContentOffset(CGPoint(x:newOffsetX, y:0), animated: false)
            }, completion: { (didFinish) in
                self.setControllersToMaxScaleWithDuration(timeInterval: 0.4)
                self.currentControllerIndex = sender.tag;
                self.trackScreenInfoForIndex(index: self.currentControllerIndex, didUseNavButton: true)
            })
        }
    }
    
    // Scrollview Delegate Methods
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageSize = scrollView.contentSize.width / CGFloat(self.activeControllers.count)
        let pageLandedOn = scrollView.contentOffset.x / pageSize;
        self.currentControllerIndex = Int(pageLandedOn);
        trackScreenInfoForIndex(index:self.currentControllerIndex, didUseNavButton:false)
    }
}
