//
//  HWChangePhoneSuccedVC.swift
//  Partner-Swift
//
//  Created by wuxiaohong on 15/2/16.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWChangePhoneSuccedVC: HWBaseViewController {
     let nameLab = UILabel()
     var changePhoneSuccess:UIViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
         func viewWillAppear(animated: Bool)
        {
            self.navigationController?.navigationBarHidden = false
        }

        self.navigationItem.titleView = Utility .navTitleView("修改手机号")
        let imageView = UIImageView(frame: CGRectMake(0, 0, 50,50 * kRate))
        imageView.center = CGPointMake(kScreenWidth/2, 60)
        imageView.image = UIImage(named: "success")
        self.view .addSubview(imageView)
        let lab = UILabel(frame: CGRectMake(0, 0, 200, 20 * kRate))
        lab.textAlignment = NSTextAlignment(rawValue: 1)!
        lab.center = CGPointMake(imageView.center.x, imageView.center.y+50)
        lab.text = "修改成功，当前手机号:"
        lab.font = Define.font(13)
        lab.textColor = CD_MainColor
        self.view .addSubview(lab)
        
        nameLab.frame =  CGRectMake(0, 0, 100, 30 * kRate)
        nameLab.center = CGPointMake(lab.center.x, lab.center.y+20)
        nameLab.textAlignment = NSTextAlignment(rawValue: 1)!
        nameLab.font = Define.font(13)
        nameLab.textColor = CD_MainColor
        self.view .addSubview(nameLab)
       
        
        let label = UILabel(frame: CGRectMake(0, 0, 100, 30 * kRate))
        label.center = CGPointMake(nameLab.center.x, nameLab.center.y+40)
        label.text = "您可以"
        label.textAlignment = NSTextAlignment(rawValue: 1)!
        label.font = Define.font(13)
        label.textColor = CD_Txt_Color_99
        self.view .addSubview(label)

        let logoutBtn = UIButton(frame: CGRectMake(15, label.frame.origin.y+40, self.view.frame.size.width-30, 45 * kRate))
        logoutBtn .setTitle("返回个人信息", forState: UIControlState.Normal)
        logoutBtn.backgroundColor  = CD_MainColor
        logoutBtn.layer.cornerRadius = 3
        //logoutBtn .setButtonRoundBorderStyle()
        logoutBtn .addTarget(self, action: "back", forControlEvents:UIControlEvents.TouchUpInside)
        self.view .addSubview(logoutBtn)

    }
   func back()
   {
       var vc = HWPersonalCenterViewController()
       // vc = shareAppDelegate.window?.rootViewController
      // self.navigationController?.popToViewController(vc, animated: true)
//      var allViewControllers:[AnyObject]  = Array()
//      allViewControllers = self.navigationController?.viewControllers
       var allViewControllers = self.navigationController?.viewControllers
//    println(allViewControllers)
    //let vc :UIViewController = allViewControllers
       self.navigationController?.popToViewController(changePhoneSuccess!, animated: true)
    
    
    
    

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

   
}
