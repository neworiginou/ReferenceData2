//
//  HWGroupMessageViewController.swift
//  Partner-Swift
//
//  Created by gusheng on 15/3/2.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit
import MessageUI
class HWGroupMessageViewController: HWBaseViewController,selectCustomerNumDelegate,MFMessageComposeViewControllerDelegate
{
    var customerLabel:UILabel!;
    var phoneArry = NSArray()
    var customerTableV:HWSelectCustomerView! = nil;
    var isSelectAll:Bool!

    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
        
    }
    override func viewDidLoad()
    {
               super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        self.navigationItem.titleView = Utility.navTitleView("选择短信群发客户");
        //创建录入客户视图
        var selectCustomerVFrame = CGRectMake(0, contentHeight-44, kScreenWidth, 44);
        var selectCustomerV:UIImageView = createCustomerImageView(selectCustomerVFrame, "");
        selectCustomerV.backgroundColor = CD_Btn_GrayColor_Clicked;
        selectCustomerV.userInteractionEnabled = true;
        self.view.addSubview(selectCustomerV);
        
        //
        
        var selectFrame2:CGRect = CGRectMake(15, 5, 70, 35)
        var btn:UIButton = createCustomeBtn(self, "selectAllCustomer:", selectFrame2, nil, "", "");
       // btn.backgroundColor = UIColor .whiteColor()
         //selectCustomerV.addSubview(btn);
        
        
        
        var selectFrame:CGRect = CGRectMake(15,15, 35, 15)
        var selectBtn:UIButton = createCustomeBtn(self, "selectAllCustomer:", selectFrame, nil, "", "");
        selectBtn.layer.cornerRadius = 3.0;
        selectBtn.layer.masksToBounds = true;
        //selectBtn.selected = true
        isSelectAll = true
        selectBtn.setImage(UIImage(named: "choose_3_1"), forState: UIControlState.Normal);
        selectBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
//        selectBtn.setBackgroundImage(UIImage(named: "choose_3_2"), forState: UIControlState.Selected);
        selectCustomerV.addSubview(selectBtn);
        
        
        var selectFrame1:CGRect = CGRectMake(40,5, 50, 35)
        var lab:UILabel = createCustomeLabel(selectFrame1, UIColor .whiteColor(), "全选",TF_13);
        selectCustomerV.addSubview(lab);

//        self.navigationItem.rightBarButtonItem = Utility .navButton(self, _title: "全选", _selector: "selectAllCustomer:")
        

        var customerNumLabelFrame:CGRect = CGRectMake(kScreenWidth-15-70-30-70,(44-16)/2,100, 16);
        customerLabel = createCustomeLabel(customerNumLabelFrame, CD_Txt_Color_ff, "已选择个客户", TF_14);
        selectCustomerV.addSubview(customerLabel);
        
        var selectCustomerBtnFrame = CGRectMake(kScreenWidth-15-70, 5, 70, 35);
        var selectCustomerBtn:UIButton = createCustomeBtn(self, "selectCustomer", selectCustomerBtnFrame, nil, "", "");
        selectCustomerBtn.layer.cornerRadius = 3.0;
        selectCustomerBtn.layer.masksToBounds = true;
        selectCustomerBtn.backgroundColor = CD_MainColor;
        selectCustomerBtn.setTitle("确定", forState: UIControlState.Normal);
        selectCustomerBtn .setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal);
        selectCustomerV.addSubview(selectCustomerBtn);
        //
        
        customerTableV = HWSelectCustomerView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight-44));
        customerTableV.delegate = self;
        customerTableV.userInteractionEnabled = true;
        self.view.addSubview(customerTableV);
    }
    func selectCustomerNum(customerNum: NSString, customerArry: NSMutableArray)
    {
       customerLabel.text = "选择"+customerNum+"个客户"
        phoneArry = NSArray(array: customerArry);
    }
    func selectAllCustomer(sender:UIButton!) ->Void
    {
        if isSelectAll == true
        {
            sender.setImage(UIImage(named: "choose_3_2-"), forState: UIControlState.Normal);
            customerTableV.totalSelectedFlag = true;
            customerTableV.didMakeAll()
        }
        else
        {
            
            sender.setImage(UIImage(named: "choose_3_1"), forState: UIControlState.Normal);
            customerTableV.totalSelectedFlag = false;
            customerTableV.disMakeAll()
        }
        isSelectAll = !isSelectAll
    }

    func selectCustomer()->Void
    {
        var arry = NSMutableArray()
        for var i = 0; i<phoneArry.count;i++
        {
            var clientModel = phoneArry .objectAtIndex(i) as HWClientModel
            arry .addObject(clientModel.clientPhone)
        
        }
        self .sendSms("", recipientList: arry)
    }
    //MARK:-短信方法
    func sendSms(bodyOfMessage:String,recipientList:NSArray)->Void
    {
        if(recipientList.count == 0)
        {
            Utility.showToastWithMessage("请选择联系人", _view: self.view);
            return;
        }
        var controller:MFMessageComposeViewController = MFMessageComposeViewController();
        if(MFMessageComposeViewController.canSendText())
        {
            controller.body = bodyOfMessage;
            controller.recipients = recipientList;
            controller.messageComposeDelegate = self;
            self.presentViewController(controller, animated: true, completion: nil);
        }
    }
    //处理发送完的响应结果
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult)
    {
        controller.dismissViewControllerAnimated(true, completion: nil);
        //短信发送后状态码没法比较
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
