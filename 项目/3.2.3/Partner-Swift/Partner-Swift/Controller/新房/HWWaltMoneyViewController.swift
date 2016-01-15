//
//  HWWaltMoneyViewController.swift
//  Partner-Swift
//
//  Created by wuxiaohong on 15/5/20.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWWaltMoneyViewController: HWBaseViewController {
    var money:String!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.titleView = Utility.navTitleView("分享成功")
        let scroll = UIScrollView(frame: CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height))
        self.view .addSubview(scroll)
        scroll.backgroundColor = CD_BackGroundColor
        scroll.contentSize = CGSizeMake(0, self.view.frame.size.height+80)
        var image1 = UIImageView(frame: CGRectMake(90, 60, kScreenWidth-170, 40))
        if iPhone6plus
        {
            image1.frame  = CGRectMake(90, 60, kScreenWidth-200, 40)
        }
        image1.image = UIImage(named: "share3.2icon1.png")
        scroll .addSubview(image1)
        var image2 = UIImageView(frame: CGRectMake(0 , 0, 110,110))
        image2.center = CGPointMake(image1.center.x, image1.center.y+70)
        image2.image = UIImage(named: "share3.2icon2.png")
        scroll .addSubview(image2)
        
        var lab = UILabel(frame: CGRectMake(0,0, 120, 50))
        lab.center = CGPointMake(image2.center.x-5, image2.center.y)
        lab.textAlignment = NSTextAlignment(rawValue: 1)!
        //lab.backgroundColor = UIColor.blackColor()

        if countElements(money) == 0
        {
             lab.text = "￥0"
          

        }
        else
        {
           

             lab.text = "￥"+money
        }
     
        lab.textColor = CD_RedDeepColor
        lab.font = Define.font(25)
        scroll .addSubview(lab)

        
        var lab1 = UILabel(frame: CGRectMake(15, CGRectGetMaxY(image2.frame)+40, kScreenWidth-30, 40))
        if countElements(money) == 0
        {
             lab1.text = "恭喜您,分享成功,获得0元现金!"
        }
        else
        {
            lab1.text = "恭喜您,分享成功,获得\(money)元现金!"
            
        }
        lab1.textAlignment = NSTextAlignment(rawValue: 1)!
        lab1.font = Define.font(18)
        lab1.textColor = CD_MainColor
        scroll .addSubview(lab1)
        var lab2 = UILabel(frame: CGRectMake(30, CGRectGetMaxY(lab1.frame)+10, kScreenWidth-60, 30))
        lab2.text = "扣除20％平台服务费后进入钱包"
        lab2.textAlignment = NSTextAlignment(rawValue: 1)!

        lab2.textColor = CD_Txt_Color_99
        scroll .addSubview(lab2)
        let logoutBtn = UIButton(frame: CGRectMake(15,CGRectGetMaxY(lab2.frame)+30 , self.view.frame.size.width-30 , 45 * kRate))
        logoutBtn.setTitle("确定", forState: UIControlState.Normal)
        logoutBtn.backgroundColor  = CD_MainColor
        logoutBtn.layer.cornerRadius = 3
        logoutBtn.addTarget(self, action: "doConfirm", forControlEvents:UIControlEvents.TouchUpInside)
        scroll .addSubview(logoutBtn)

        
    }
     override func backMethod() {
       // NSNotificationCenter.defaultCenter.postNotificationName:"queryListData" ,object:nil
        NSNotificationCenter .defaultCenter() .postNotificationName("queryListData", object: nil)
        self.navigationController?.popViewControllerAnimated(true)
    }
   func doConfirm()
   {
      NSNotificationCenter .defaultCenter() .postNotificationName("queryListData", object: nil) 
      self.navigationController?.popViewControllerAnimated(true)
   }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
