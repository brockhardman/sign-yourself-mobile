//
//  UIViewController+Extensions.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 8/12/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

import Foundation

import UIKit
import ViewPager_Swift
import DropDown
//MARK: -UIViewController Extension for Toast and cliping Views
extension UIViewController{
    func toastView(messsage : String, view: UIView ){
        let toastLabel = UILabel(frame: CGRect(x: view.frame.size.width/2-125, y: view.frame.size.height/2, width: 250,  height : 35))
        toastLabel.backgroundColor = UIColor.black
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = NSTextAlignment.center;
        view.addSubview(toastLabel)
        toastLabel.text = messsage
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        UIView.animate(withDuration: 2.0, delay: 0.00, options: UIView.AnimationOptions.curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        })
        
    }
    func clipBounds(view:UIView,cornerRadius:CGFloat,opacity:Float,dropShadow:Bool) {
        view.layer.cornerRadius = cornerRadius
        view.clipsToBounds = true
        if dropShadow{
            view.dropShadow(color: UIColor.black, opacity: opacity, offSet: CGSize.init(width: 0, height: 4), radius: 1.0, scale: true)
            
        }
    }
    func transitionFromleft(view:UIView)  {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
    }
}
//MARK: - Extension For Global ProgressUtil
extension UIViewController{
    var viewHalfWidthMinus50: CGFloat{
        get {
            return view.frame.size.width/2 - 50
        }
        
    }
    var viewHalfWidthPlus50: CGFloat {
        get {
            return view.frame.size.width/2 + 50
        }
    }
    var viewHalfHeight: CGFloat {
        get {
            return view.frame.size.height/2
        }
    }
    
    func startAll(view1: UIView, view2: UIView, view3: UIView, view4: UIView,backgroundView:UIView){
        start1(val: true, view1: view1, view2: view2, view3: view3, view4: view4, backgroundView: backgroundView)
        start2(val: true, view2: view2)
        start3(val: true, view3: view3)
        start4(val: true, view4: view4)
    }
    
    func startOrStopAnimating(view:UIView,start:Bool) {
        if start{
            
            let backgroundView = UIView()
            backgroundView.frame.size.height = view.frame.size.height
            backgroundView.frame.size.width = view.frame.size.height
            //            backgroundView.backgroundColor = UIColor.transparentLight
            
            let view1 = UIView()
            view1.frame.size.height = 50
            view1.frame.size.width = 50
            view1.center.x = CGFloat(viewHalfWidthMinus50)
            view1.center.y = CGFloat(viewHalfHeight)
            //            view1.backgroundColor = UIColor.color1
            view.tag = 0
            
            let view2 = UIView()
            view2.frame.size.height = 50
            view2.frame.size.width = 50
            view2.center.x = CGFloat(viewHalfWidthMinus50)
            view2.center.y = CGFloat(viewHalfHeight)
            //            view2.backgroundColor = UIColor.color2
            let view3 = UIView()
            view3.frame.size.height = 50
            view3.frame.size.width = 50
            view3.center.x = CGFloat(viewHalfWidthMinus50)
            view3.center.y = CGFloat(viewHalfHeight)
            //            view3.backgroundColor = UIColor.color3
            let view4 = UIView()
            view4.frame.size.height = 50
            view4.frame.size.width = 50
            view4.center.x = CGFloat(viewHalfWidthMinus50)
            view4.center.y = CGFloat(viewHalfHeight)
            //            view4.backgroundColor = UIColor.color4
            
            clipBounds(view: view1, cornerRadius: view1.frame.size.height/2)
            clipBounds(view: view2, cornerRadius: view1.frame.size.height/2)
            clipBounds(view: view3, cornerRadius: view1.frame.size.height/2)
            clipBounds(view: view4, cornerRadius: view1.frame.size.height/2)
            view.addSubview(backgroundView)
            view.addSubview(view1)
            view.addSubview(view2)
            view.addSubview(view3)
            view.addSubview(view4)
            
            startAll(view1: view1, view2: view2, view3: view3, view4: view4,backgroundView:backgroundView)
            
        }else{
            view.tag = 1
        }
        
    }
    
    public func start1(val:Bool,view1:UIView,view2:UIView,view3:UIView,view4:UIView,backgroundView:UIView) {
        let val1 = !val
        UIView.animate(withDuration: 0.8, animations:{
            if val{
                view1.center.x = self.viewHalfWidthPlus50
            }else{
                view1.center.x = self.viewHalfWidthMinus50
            }
            
        }) { (completed) in
            if view1.superview?.tag == 0 {
                self.start1(val:val1,view1:view1,view2:view2,view3:view3,view4:view4, backgroundView: backgroundView)
                self.start2(val:val1, view2: view2)
                self.start3(val:val1, view3: view3)
                self.start4(val:val1, view4: view4)
            }
            else{
                view1.removeFromSuperview()
                view2.removeFromSuperview()
                view3.removeFromSuperview()
                view4.removeFromSuperview()
                backgroundView.removeFromSuperview()
                
            }
        }
        
    }
    
    public func start2(val:Bool,view2:UIView) {
        UIView.animate(withDuration: 0.6,animations: {
            if val{
                view2.center.x = self.viewHalfWidthPlus50
            }else{
                view2.center.x = self.viewHalfWidthMinus50
            }
        }) { (completed) in
            
        }
        
    }
    public func start3(val:Bool,view3:UIView) {
        UIView.animate(withDuration: 0.4,animations: {
            if val{
                view3.center.x = self.viewHalfWidthPlus50
            }else{
                view3.center.x = self.viewHalfWidthMinus50
            }
        }) { (completed) in
            
        }
    }
    
    
    public func start4(val:Bool,view4:UIView) {
        UIView.animate(withDuration: 0.2,animations: {
            if val{
                view4.center.x = self.viewHalfWidthPlus50
            }else{
                view4.center.x = self.viewHalfWidthMinus50
            }
        }) { (completed) in
            
        }
        
    }
    func clipBounds(view:UIView,cornerRadius:CGFloat) {
        view.layer.cornerRadius = cornerRadius
        view.clipsToBounds = true
        
    }
    
    func getViewPagerOptions(view:UIView,tabViewHeight:CGFloat = 50,tabBackgroundColor:UIColor = UIColor.lightGray,tabSelectedIndicatorColor:UIColor = UIColor.navSelectedBackgroundColor,textColor:UIColor = .darkGray) -> ViewPagerOptions {
        let options = ViewPagerOptions(viewPagerWithFrame: view.bounds)
        options.tabType = ViewPagerTabType.basic
        options.tabViewTextDefaultColor = textColor
        options.tabViewTextFont = UIFont.systemFont(ofSize: 12)
        options.tabViewBackgroundDefaultColor = tabBackgroundColor
        options.tabViewPaddingLeft = 20
        options.tabViewPaddingRight = 20
        options.tabViewHeight = tabViewHeight
        options.fitAllTabsInView = true
        options.viewPagerTransitionStyle = .scroll
        options.isEachTabEvenlyDistributed = true
        options.tabIndicatorViewBackgroundColor = tabSelectedIndicatorColor
        return options
    }
    
    func setButtonGroup(buttonClicked:UIButton,button:UIButton) {
        buttonClicked.setImage(#imageLiteral(resourceName: "circle_filled"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "circle"), for: .normal)
    }
    
    func setUpButton(button:UIButton,checkedImage:UIImage = #imageLiteral(resourceName: "circle_tick"),uncheckedImage:UIImage = #imageLiteral(resourceName: "circle")) {
        if button.image(for: .normal) == checkedImage{
            button.setImage(uncheckedImage, for: .normal)
        }else{
            button.setImage(checkedImage, for: .normal)
        }
    }
    
    //MARK:Set up DropDown
    func getDropDown(width:CGFloat,dataSource:[String],bottomOffset:CGPoint) -> DropDown {
        let dropDown = DropDown()
        dropDown.backgroundColor = .white
        dropDown.bottomOffset = bottomOffset
        dropDown.width = width
        dropDown.direction = .any
        dropDown.dataSource = dataSource
        
        return dropDown
    }
    //MARK:setup the View Groups
    func setUpButtonGroup(buttonClicked:UIButton,buttonList:[UIButton]) {
        for button in buttonList {
            if button == buttonClicked{
                button.backgroundColor = UIColor.navSelectedBackgroundColor
                button.setTitleColor(UIColor.white, for: .normal)
            }else{
                button.setTitleColor(UIColor.navSelectedBackgroundColor, for: .normal)
                button.backgroundColor = .white
            }
        }
    }
    
    func setUpViewGroup(viewTapped:UIView,setViewGroupModalList:[SetViewGroupModal])  {
        for views in setViewGroupModalList {
            if views.view == viewTapped{
                views.view?.backgroundColor = UIColor.navSelectedBackgroundColor
                views.title?.textColor = UIColor.white
                views.subTitle?.textColor = UIColor.white
            }else{
                views.view?.backgroundColor = UIColor.white
                views.title?.textColor = UIColor.black
                views.subTitle?.textColor = UIColor.darkGray
            }
        }
    }
    
    
}
