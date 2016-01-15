//
//  GuillotineViewController.swift
//  GuillotineMenu
//
//  Created by Maksym Lazebnyi on 3/24/15.
//  Copyright (c) 2015 Yalantis. All rights reserved.
//

import UIKit

class GuillotineMenuViewController: UIViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var avaterImageView: UIImageView!
    var hostNavigationBarHeight: CGFloat!
    var hostTitleText: NSString!

    var menuButton: UIButton!
    var menuButtonLeadingConstraint: NSLayoutConstraint!
    var menuButtonTopConstraint: NSLayoutConstraint!
    
    private let menuButtonLandscapeLeadingConstant: CGFloat = 1
    private let menuButtonPortraitLeadingConstant: CGFloat = 7
    private let hostNavigationBarHeightLandscape: CGFloat = 32
    private let hostNavigationBarHeightPortrait: CGFloat = 44
    
    @IBAction func swipeGestureAction(sender: UISwipeGestureRecognizer) {
        
        self.closeMenuButtonTapped()
        
    }
    @IBOutlet weak var levelStartView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        avaterImageView.layer.cornerRadius = avaterImageView.bounds.height/2
        avaterImageView.layer.masksToBounds = true
        levelStartView.getLevelStar(5)
    
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

    }
    
  //realNameRenZhen
    @IBAction func realNameRenZheng(sender: UIButton) {
        print("hello")
        let storyBoadrd = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let realNameRenZhenStoryboard:UINavigationController = storyBoadrd.instantiateViewControllerWithIdentifier("realNameRenZhen") as! UINavigationController
        self.bgView.removeFromSuperview()
        self.settingButton.removeFromSuperview()
        self.menuButton.removeFromSuperview()
        
        // self.navigationController?.presentViewController(systemSettingStoryBoard, animated: true, completion: nil)
        self.presentViewController(realNameRenZhenStoryboard, animated: true) { () -> Void in
            var i = 0
            //内存管理-处理视图叠加导致内存暴增
            let window = UIApplication.sharedApplication().keyWindow?.subviews
            if let _ = window {
                for var view:UIView in (window)! {
                    if i != (window?.count)! - 1 {
                        view.removeFromSuperview()
                    }
                    i++
                }
            }
        }

        
    }
    
    @IBAction func systemSetting(sender: UIButton) {
        
        let storyBoadrd = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let systemSettingStoryBoard:UINavigationController = storyBoadrd.instantiateViewControllerWithIdentifier("navigationSystemSetting") as! UINavigationController
        self.bgView.removeFromSuperview()
        self.settingButton.removeFromSuperview()
        self.menuButton.removeFromSuperview()
        
       // self.navigationController?.presentViewController(systemSettingStoryBoard, animated: true, completion: nil)
        self.presentViewController(systemSettingStoryBoard, animated: true) { () -> Void in
            var i = 0
            //内存管理-处理视图叠加导致内存暴增
            let window = UIApplication.sharedApplication().keyWindow?.subviews
            if let _ = window {
                for var view:UIView in (window)! {
                    if i != (window?.count)! - 1 {
                        view.removeFromSuperview()
                    }
                    i++
                }
            }
        }

        
    }
    @IBAction func historyAction(sender: UIButton) {
        let storyBoadrd = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let freeStoryBoard:UINavigationController = storyBoadrd.instantiateViewControllerWithIdentifier("historyNavigation") as! UINavigationController
        self.bgView.removeFromSuperview()
        self.settingButton.removeFromSuperview()
        self.menuButton.removeFromSuperview()
        self.presentViewController(freeStoryBoard, animated: true) { () -> Void in
            var i = 0
            //内存管理-处理视图叠加导致内存暴增
            let window = UIApplication.sharedApplication().keyWindow?.subviews
            if let _ = window {
                for var view:UIView in (window)! {
                    if i != (window?.count)! - 1 {
                        view.removeFromSuperview()
                    }
                    i++
                }
            }
        }
        
        
    }
    
    /**
       资料设置action
        profileSetting navigation -id
     - parameter sender: sender
     */
    @IBAction func profileSetting(sender: UIButton) {
        
        let storyBoadrd = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let freeStoryBoard:UINavigationController = storyBoadrd.instantiateViewControllerWithIdentifier("profileSetting") as! UINavigationController
        self.bgView.removeFromSuperview()
        self.settingButton.removeFromSuperview()
        self.menuButton.removeFromSuperview()
        self.presentViewController(freeStoryBoard, animated: true) { () -> Void in
            var i = 0
            //内存管理-处理视图叠加导致内存暴增
            let window = UIApplication.sharedApplication().keyWindow?.subviews
            if let _ = window {
                for var view:UIView in (window)! {
                    if i != (window?.count)! - 1 {
                        view.removeFromSuperview()
                    }
                    i++
                }
            }
        }
        
    }
    @IBAction func FreeTimeAction(sender: UIButton) {

        let storyBoadrd = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let freeStoryBoard:UINavigationController = storyBoadrd.instantiateViewControllerWithIdentifier("freeTimeViewNavigation") as! UINavigationController
        self.bgView.removeFromSuperview()
        self.settingButton.removeFromSuperview()
        self.menuButton.removeFromSuperview()
            self.presentViewController(freeStoryBoard, animated: true) { () -> Void in
                var i = 0
                //内存管理-处理视图叠加导致内存暴增
                let window = UIApplication.sharedApplication().keyWindow?.subviews
                if let _ = window {
                    for var view:UIView in (window)! {
                        if i != (window?.count)! - 1 {
                            view.removeFromSuperview()
                        }
                        i++
                    }
                }
            }
        
    }
    //historyNavigation
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
        coordinator.animateAlongsideTransition(nil) { (context) -> Void in
            if UIDevice.currentDevice().orientation == .LandscapeLeft || UIDevice.currentDevice().orientation == .LandscapeRight {
                self.menuButtonLeadingConstraint.constant = self.menuButtonLandscapeLeadingConstant
                self.menuButtonTopConstraint.constant = self.menuButtonPortraitLeadingConstant
            } else {
                let statusbarHeight = UIApplication.sharedApplication().statusBarFrame.size.height
                self.menuButtonLeadingConstraint.constant = self.menuButtonPortraitLeadingConstant;
                self.menuButtonTopConstraint.constant = self.menuButtonPortraitLeadingConstant+statusbarHeight
            }
        }
    }
    
// MARK: Actions
    func closeMenuButtonTapped() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setMenuButtonWithImage(image: UIImage) {
        let statusbarHeight = UIApplication.sharedApplication().statusBarFrame.size.height
        
        let buttonImage = UIImage(CGImage: image.CGImage!, scale: 1.0, orientation: .Right)
        
        if UIDevice.currentDevice().orientation == .LandscapeLeft || UIDevice.currentDevice().orientation == .LandscapeRight {
            menuButton = UIButton(frame: CGRectMake(menuButtonPortraitLeadingConstant, menuButtonPortraitLeadingConstant+statusbarHeight, 30.0, 30.0))
        } else {
            menuButton = UIButton(frame: CGRectMake(menuButtonPortraitLeadingConstant, menuButtonPortraitLeadingConstant+statusbarHeight, 30.0, 30.0))
        }
        
        menuButton.setImage(image, forState: .Normal)
        menuButton.setImage(image, forState: .Highlighted)
        menuButton.imageView!.contentMode = .Center
        menuButton.addTarget(self, action: Selector("closeMenuButtonTapped"), forControlEvents: .TouchUpInside)
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.transform = CGAffineTransformMakeRotation( ( 90 * CGFloat(M_PI) ) / 180 );
        self.view.addSubview(menuButton)
        
        if UIDevice.currentDevice().orientation == .LandscapeLeft || UIDevice.currentDevice().orientation == .LandscapeRight {
           var (leading, top) = self.view.addConstraintsForMenuButton(menuButton, offset: UIOffsetMake(menuButtonLandscapeLeadingConstant, menuButtonPortraitLeadingConstant))
            menuButtonLeadingConstraint = leading
            menuButtonTopConstraint = top
        } else {
            var (leading, top) = self.view.addConstraintsForMenuButton(menuButton, offset: UIOffsetMake(menuButtonPortraitLeadingConstant, menuButtonPortraitLeadingConstant+statusbarHeight))
            menuButtonLeadingConstraint = leading
            menuButtonTopConstraint = top
        }
        
    }

}

extension GuillotineMenuViewController: GuillotineAnimationProtocol {

    func anchorPoint() -> CGPoint {
        if UIDevice.currentDevice().orientation == .LandscapeLeft || UIDevice.currentDevice().orientation == .LandscapeRight {
            //In this case value is calculated manualy as the method is called before viewDidLayourSubbviews when the menuBarButton.frame is updated.
            return CGPointMake(16, 16)
        }
        return self.menuButton.center
    }
    
    func navigationBarHeight() -> CGFloat {
        if UIDevice.currentDevice().orientation == .LandscapeLeft || UIDevice.currentDevice().orientation == .LandscapeRight {
            return hostNavigationBarHeightLandscape
        } else {
            return hostNavigationBarHeightPortrait
        }
    }
    
    func hostTitle () -> NSString {
        return hostTitleText
    }
}
