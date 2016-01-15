//
//  HWBaoBeiVC.swift
//  Partner-Swift
//
//  Created by zhangxun on 15/3/5.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWBaoBeiVC: UIViewController,HWCustomerInfoViewDelegate,HWCustomerSearchDelegate {
    
    var countLabel : UILabel!
    var btn : UIButton!
    var customInfoView : HWCustomerInfoView!
    var projgectId : NSString!
    var selArr : NSArray?
    var houseId : NSString!
    var houseName : NSString!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.titleView = Utility.navTitleView("报备客户")
        self.navigationItem.leftBarButtonItem = Utility.navLeftBackBtn(self, _selector: "backMethod")
        self.navigationItem.rightBarButtonItem = Utility.navButton(self, _title: "添加", _selector: "addCustom")
        
        customInfoView = HWCustomerInfoView(frame: CGRectMake(0, 45, kScreenWidth, contentHeight - 57 - 45))
        customInfoView.sourceMode = ClientSource.NewHouseRelate
        customInfoView.selectMode = ClientSelectMode.Multiplicity
        customInfoView.delegate = self
        customInfoView.houseId = houseId
        self.view.addSubview(customInfoView)
        
        var bottomView = UIView(frame: CGRectMake(0, contentHeight - 57, kScreenWidth, 57))
        bottomView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        var nameLabel = UILabel(frame: CGRectMake(15, 10, kScreenWidth - 100 - 30, 15))
        nameLabel.backgroundColor = UIColor.clearColor()
        nameLabel.font = UIFont(name: FONTNAME, size: 15)
        nameLabel.textColor = UIColor.whiteColor()
        nameLabel.text = houseName as String
        bottomView.addSubview(nameLabel)
        
        countLabel = UILabel(frame: CGRectMake(15, 27, kScreenWidth - 100 - 30, 20))
        countLabel.backgroundColor = UIColor.clearColor()
        bottomView.addSubview(countLabel)
        
        btn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        btn.frame = CGRectMake(kScreenWidth - 100 - 15, 10, 100, 35)
        btn.setBackgroundImage(Utility.imageWithColor(CD_Btn_MainColor, _size: CGSizeMake(1, 1)), forState: UIControlState.Normal)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 3.0
        btn.titleLabel?.textColor = UIColor.whiteColor()
        btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        btn.setTitle("确定", forState: UIControlState.Normal)
        btn.addTarget(self, action: "doSubmit", forControlEvents: UIControlEvents.TouchUpInside)
        bottomView.addSubview(btn)
        
        self.view.addSubview(bottomView)
        
        var searchView : HWCustomerSearchView = HWCustomerSearchView(frame: CGRectMake(0, 0, kScreenWidth, 45),type:"0")
        searchView.delegate = self
        self.view.addSubview(searchView)
        self.setCount(0)
    }
    
    func backMethod()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func addCustom(){
        var logginCustomerV:HWLoggingCustomerVC = HWLoggingCustomerVC();
        logginCustomerV.titileType = "0"
        logginCustomerV.agentClientModel == Optional.None
        logginCustomerV.myFunc = { ()->Void in
            self.customInfoView.currentPage = 1
            self.customInfoView.newHouseQueryListData()
        }
        self.navigationController?.pushViewController(logginCustomerV, animated: true);
    }
    
    func setCount(count : Int)
    {
        if count == 0
        {
            btn.setTitleColor(UIColor(white: 1, alpha: 0.5), forState: UIControlState.Normal)
            btn.userInteractionEnabled = false
        }
        else
        {
            btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            btn.userInteractionEnabled = true
        }
        var countStr : NSString = "\(count)"
        var str : NSString = "已选择报备客户 " + (countStr as String)
        var attStr : NSMutableAttributedString = NSMutableAttributedString(string: str as String)
        attStr.addAttribute(NSForegroundColorAttributeName, value: "d6d6d6".UIColor, range: NSMakeRange(0, str.length))
        attStr.addAttribute(NSFontAttributeName, value: UIFont(name: FONTNAME, size: 14)!, range: NSMakeRange(0, str.length))
        attStr.addAttribute(NSForegroundColorAttributeName, value: CD_Btn_MainColor, range: NSMakeRange(8,countStr.length))
        attStr.addAttribute(NSFontAttributeName, value: UIFont(name: FONTNAME, size: 15)!, range: NSMakeRange(8, countStr.length))
        countLabel.attributedText = attStr
    }
    
    func didSelectedCustomer(customerArr: NSArray?) -> Void
    {
        self.setCount(customerArr!.count)
        selArr = customerArr
    }
    
    func doSubmit()
    {
        var dict : NSMutableDictionary = NSMutableDictionary()
        dict.setObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        dict.setObject(houseId, forKey: "projectId")
        
        var clients : NSMutableString = NSMutableString()
        if selArr != nil
        {
            for var i = 0; i < selArr?.count; i++
            {
                var client = selArr?[i] as HWClientModel
                if i == selArr!.count - 1
                {
                    clients.appendString(client.clientInfoId as String)
                }else{
                    clients.appendString(client.clientInfoId as String)
                    clients.appendString(",")
                }
            }
        }
        dict.setObject(clients, forKey: "clientList")
        Utility.hideMBProgress(self.view)
        Utility.showMBProgress(self.view, _message: "请稍等")
        var manager : HWHttpRequestOperationManager = HWHttpRequestOperationManager.baseManager()
        manager.postHttpRequest(kBaoBeiCustomer, parameters: dict, queue: nil, success: { (responseObject) -> Void in
            
            Utility.hideMBProgress(self.view)
            var dic:NSDictionary = responseObject as NSDictionary;
            Utility.showToastWithMessage(dic.stringObjectForKey("detail"), _view: shareAppDelegate.window!);
            self.navigationController?.popViewControllerAnimated(true)
            
        }) { (failure, error) -> Void in
            Utility.hideMBProgress(self.view)
            Utility.showToastWithMessage(error as String, _view: self.view)
        }
    }
    
    func pop(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func didSearchTitle(title:NSString)->Void
    {
        customInfoView.setSearchKey(title)
    }
    func didSelectMenuByIndex(index: NSInteger)
    {
        customInfoView.setSearchFilterIndex(index)
    }
    func didSelectMenufirstIdAndSecondId(first: NSString, second: NSString) {
        
    }
    func didMenuEnd()->Void
    {
        
    }
    func didMenuStart()->Void
    {
        
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
