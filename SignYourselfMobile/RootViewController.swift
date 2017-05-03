//
//  RootViewController.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 4/22/17.
//  Copyright © 2017 SignYourself. All rights reserved.
//

import UIKit

//typedef void(^ActiveControllersCompletionBlock)(void);

class RootViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    var mainPinchGestureMaxScale:CGFloat = 1.0
    var mainPinchGestureMinScale:CGFloat = 0.5
    var activeControllers = NSArray()
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
        
        let pinchGesture : UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action:#selector(userDidPinch))
        self.scrollView?.addGestureRecognizer(pinchGesture)
        self.scrollView?.delegate = self;
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
        }
    }
    
    func buildBottomNavWithActiveControllers() {
        let screenRect = UIScreen.main.bounds;
        let navButtonWidth = screenRect.size.width / CGFloat(self.activeControllers.count);
        var counter = 0.0;
        
        for index in 0...self.activeControllers.count-1 {
            
            let beginX = CGFloat(counter) * navButtonWidth;
            let navButtonView = UIView(frame: CGRect(x:beginX,y:0, width:navButtonWidth, height:(self.bottomNavView?.frame.size.height)!))
            navButtonView.backgroundColor = UIColor.clear
        
            let navButton = UIButton()
            navButton.frame = CGRect(x: 0, y: 0, width: navButtonWidth, height: (self.bottomNavView?.frame.size.height)!)
            navButton.tag = Int(counter);
            navButton.addTarget(self, action: #selector(navButtonTapped), for: UIControlEvents.touchUpInside)
            let dict = self.activeControllers.object(at: index) as! NSDictionary
            navButton.setTitle(dict.object(forKey: "navTitle") as? String, for: UIControlState.normal)
            navButton.titleLabel?.textAlignment = NSTextAlignment.center;
            navButton.titleEdgeInsets = UIEdgeInsets(top:(self.bottomNavView?.frame.size.height)! - 18, left:0, bottom:0, right:0);
            navButton.titleLabel?.font = UIFont(name:"Helvetica", size:10)
            navButton.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
            navButtonView.addSubview(navButton)
            
    //        UIImageView *buttonImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:activeViewController.navigationImage]];
    //        [buttonImageView setCenter:CGPointMake(navButtonWidth / 2, buttonImageView.frame.size.height / 2 + 3)];
    //        [buttonImageView setBackgroundColor:[UIColor clearColor]];
    //        [navButtonView addSubview:buttonImageView];
            
            self.bottomNavView?.addSubview(navButtonView)
            counter += 1
        }
    }
    
    func setControllersToMinScaleWithDuration(timeInterval:TimeInterval)
    {
//    for (UIViewController *controller in self.activeControllers)
//    {
//    SYSActiveViewController *activeController = (SYSActiveViewController *)controller;
//    [activeController.view setClipsToBounds:NO];
//    
//    [UIView animateWithDuration:timeInterval animations:^{
//    CGAffineTransform transform = CGAffineTransformMakeScale(kMainPinchGestureMinScale, kMainPinchGestureMinScale);
//    activeController.view.transform = transform;
//    UIView *floatingTitleView = [[UIView alloc] initWithFrame:CGRectMake(activeController.view.bounds.origin.x, activeController.view.bounds.origin.y - 100, activeController.view.bounds.size.width, 50)];
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:floatingTitleView.bounds];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.text = [activeController.navigationTitle uppercaseString];
//    titleLabel.font = [UIFont systemFontOfSize:25];
//    [floatingTitleView addSubview:titleLabel];
//    [controller.view addSubview:floatingTitleView];
//    } completion:^(BOOL finished) {
//    [self addShadowToView:controller.view];
//    }];
//    }
//    
//    [self addTapGestureToView:self.scrollView];
//    self.isZoomed = YES;
    }
    
    func setControllersToMaxScaleWithDuration(timeInterval:TimeInterval)
    {
//    for (UIViewController *controller in self.activeControllers)
//    {
//    [UIView animateWithDuration:timeInterval animations:^{
//    CGAffineTransform transform = CGAffineTransformMakeScale(kMainPinchGestureMaxScale, kMainPinchGestureMaxScale);
//    controller.view.transform = transform;
//    } completion:^(BOOL finished) {
//    [self removeShadowFromView:controller.view];
//    [self removeTapGestureFromView:controller.view];
//    [controller.view setClipsToBounds:YES];
//    }];
//    }
//    
//    self.isZoomed = NO;
    }
    
//    func addShadowToView:(UIView *)view
//    {
//    CALayer *layer = [view layer];
//    [layer setMasksToBounds:NO];
//    [layer setRasterizationScale:[[UIScreen mainScreen] scale]];
//    [layer setShouldRasterize:YES];
//    [layer setShadowColor:[[UIColor blackColor] CGColor]];
//    [layer setShadowOffset:CGSizeMake(5.0f, 5.0f)];
//    [layer setShadowRadius:10.0f];
//    [layer setShadowOpacity:0.5f];
//    [layer setShadowPath:[[UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:layer.cornerRadius] CGPath]];
//    }
//    
//    func removeShadowFromView:(UIView *)view
//    {
//    CALayer *layer = [view layer];
//    [layer setShadowColor:nil];
//    [layer setShadowOffset:CGSizeZero];
//    [layer setShadowRadius:0.0f];
//    [layer setShadowOpacity:0.0f];
//    [layer setShadowPath:nil];
//    }
//    
//    func addTapGestureToView:(UIView *)view
//    {
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userDidTap:)];
//    [view addGestureRecognizer:tapGesture];
//    [self.tapGestures addObject:tapGesture];
//    }
//    
//    func removeTapGestureFromView:(UIView *)view
//    {
//    for (UIGestureRecognizer *recognizer in view.gestureRecognizers)
//    {
//    if ([self.tapGestures containsObject:recognizer])
//    {
//    [view removeGestureRecognizer:recognizer];
//    [self.tapGestures removeObject:recognizer];
//    }
//    }
//    }
    
    func userDidTap(tap: UITapGestureRecognizer)
    {
//    if (self.isZoomed)
//    {
//    [self setControllersToMaxScaleWithDuration:0.2f];
//    }
    }
    
    func updateControllersWithScale(scale:CGFloat)
    {
//    for (SYSActiveViewController *controller in self.activeControllers)
//    {
//    CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale);
//    controller.view.transform = transform;
//    }
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
//    if (self.currentControllerIndex != sender.tag)
//    {
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    CGFloat newOffsetX = screenRect.size.width * sender.tag;
//    
//    if (!self.isZoomed)
//    {
//    [self setControllersToMinScaleWithDuration:0.4f];
    }
//    
//    [UIView animateWithDuration:0.6f animations:^{
//    [self.scrollView setContentOffset:CGPointMake(newOffsetX, 0)];
//    } completion:^(BOOL finished) {
//    [self setControllersToMaxScaleWithDuration:0.4f];
//    self.currentControllerIndex = sender.tag;
//    [self trackScreenInfoForIndex:self.currentControllerIndex didUseNavigationButtons:YES];
//    }];
//    }
//    }
//    
//    #pragma mark - Active View Controller Refresh Protocol
//    
//    func layoutNeedsRefresh
//    {
//    [self.view setNeedsDisplay];
//    [self.view setNeedsLayout];
//    }
//    
//    #pragma mark - Scrollview Delegate Methods
//    
//    func scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//    {
//    NSInteger pageSize = scrollView.contentSize.width / [self.activeControllers count];
//    NSInteger pageLandedOn = scrollView.contentOffset.x / pageSize;
//    self.currentControllerIndex = pageLandedOn;
//    [self trackScreenInfoForIndex:self.currentControllerIndex didUseNavigationButtons:NO];
//    }
}
