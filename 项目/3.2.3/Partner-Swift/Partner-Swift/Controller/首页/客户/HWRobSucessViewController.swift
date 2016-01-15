//
//  HWRobSucessViewController.swift
//  Partner-Swift
//
//  Created by gusheng on 15/2/16.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWRobSucessViewController: HWBaseViewController
{
    var robClientId:NSString! = NSString();
    var protectDays:NSString! = NSString();
    var sourceStr:String! = String();
    var scdHouseId:NSString! = NSString();
    override func viewWillAppear(animated: Bool)
    {
        self.navigationController?.setNavigationBarHidden(false, animated: true);
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if(sourceStr == "1")
        {
            self.navigationItem.titleView = Utility.navTitleView("抢客成功");
        }
        else
        {
            self.navigationItem.titleView = Utility.navTitleView("抢房成功");
        }
        
        self.view.backgroundColor = CD_BackGroundColor;
        self.createGeneralView();
    }
    //remark:解决导航bar隐藏，以及返回主页闪动的BUG
    override func backMethod() -> Void
    {
        //self.navigationController?.popViewControllerAnimated(true);
        self.navigationController?.popToViewController(robVC, animated: true)
        
    }
    //end

    func createGeneralView()->Void
    {
        //勾
        var gouImageVFrame:CGRect = CGRectMake((kScreenWidth-72)/2, 35, 72, 72);
        var gouImageV:UIImageView = createCustomerImageView(gouImageVFrame,"success");
        self.view.addSubview(gouImageV);
        
        //
        var resultLabelFrame:CGRect = CGRectMake(0,CGRectGetMaxY(gouImageVFrame)+15,kScreenWidth,20);
        var resultLabelColor = CD_Btn_MainColor;
        var resultLabel:UILabel = createCustomeLabel(resultLabelFrame, resultLabelColor,"恭喜，抢客成功",TF_15);
        if(sourceStr == "2")
        {
            resultLabel.text = "恭喜，抢房成功";
        }
        resultLabel.textAlignment = NSTextAlignment.Center;
        self.view.addSubview(resultLabel);
        
        var protectTipLabelFrame:CGRect = CGRectMake(0,CGRectGetMaxY(resultLabelFrame)+10,kScreenWidth,20);
        //保护期提示
        if(sourceStr == "2")
        {
            var protectTipLabelColor = CD_Txt_Color_99;
            var protectTipLabel:UILabel = createCustomeLabel(protectTipLabelFrame, protectTipLabelColor,"",TF_13);
            if(protectDays.integerValue > 0)
            {
                protectTipLabel.text = "保护期剩余"+protectDays+"天";
            }
            protectTipLabel.textAlignment = NSTextAlignment.Center;
            self.view.addSubview(protectTipLabel);
        }
        
        
        //
        var personOwnLabelFrame:CGRect = CGRectMake(0,CGRectGetMaxY(protectTipLabelFrame)+45,kScreenWidth,20);
        var personOwnLabelColor = CD_Txt_Color_99;
        var personOwnLabel:UILabel = createCustomeLabel(personOwnLabelFrame, personOwnLabelColor,"您可以",TF_15);
        personOwnLabel.textAlignment = NSTextAlignment.Center;
        self.view.addSubview(personOwnLabel);
        
        //创建查看客户按钮
        var lookCustomerFrame:CGRect = CGRectMake(13,CGRectGetMaxY(personOwnLabelFrame)+18,kScreenWidth-2*13,45);
        var lookCustomerBtn:UIButton;
        if(sourceStr == "1")
        {
           
            lookCustomerBtn = createCustomeBtn(self,"lookCustomer", lookCustomerFrame,UIColor.whiteColor(),"查看客户","");
            lookCustomerBtn.setTitle("查看客户", forState: UIControlState.Normal);
           // lookCustomerBtn.addTarget(self, action: "lookCustomer", forControlEvents: UIControlEvents.TouchUpInside);
        }
        else
        {
            lookCustomerBtn = createCustomeBtn(self,"lookHouse", lookCustomerFrame,UIColor.whiteColor(),"查看房源","");
            lookCustomerBtn.setTitle("查看房源", forState: UIControlState.Normal);
//            lookCustomerBtn.addTarget(self, action: "lookHouse", forControlEvents: UIControlEvents.TouchUpInside);
        }
        
        lookCustomerBtn.layer.masksToBounds = true;
        lookCustomerBtn.layer.cornerRadius = 3.0;
        lookCustomerBtn.backgroundColor = CD_Btn_MainColor;
        self.view.addSubview(lookCustomerBtn);
    }
    func lookCustomer()
    {
        var customerDetailV:HWCustomerDetailViewController = HWCustomerDetailViewController();
        customerDetailV.sourceTypeStr = "1";
        customerDetailV.clientInfoId = robClientId;
        self.navigationController?.pushViewController(customerDetailV, animated: true);
    }
    func lookHouse()
    {
        var scdHouseDetailVC = HWScdHouseDetailVC()
        scdHouseDetailVC._houseId = scdHouseId;
        //        println("_houseId==\(scdHouseDetailVC._houseId)")
        self.navigationController?.pushViewController(scdHouseDetailVC, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
