//
//  HWSubordinateViewController.swift
//  Partner-Swift
//
//  Created by hw500029 on 15/2/16.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWSubordinateViewController: HWBaseViewController,HWSubordinateDelegate,HWCustomAlertViewDelegate
{
    
    var refreshView:HWSubordinateRefreshView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = Utility.navTitleView("我的下线")
        //self.navigationItem.rightBarButtonItem = Utility .navButton(self, _title: "添加", _selector: "goToCoil")
        self.navigationItem.rightBarButtonItem = Utility.navButton(self, _selector: "inviteFriend", _image: UIImage(named: "add_icon1")!)
        refreshView = HWSubordinateRefreshView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight))
        refreshView?.delegate = self
        self.view.addSubview(refreshView!)
        
    }
    
    //编辑下限昵称
    func showNickNameEditView()
    {
        let al = HWCustomAlertView(type: AlertViewType.EditNickName)
        shareAppDelegate.window?.addSubview(al)
        al.delegate = self
        al.showAnimate()
    }
    func goToCoil()
    {
    
        var vc = HWAddCoilViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
//    func action(sender:UIButton) -> Void
//    {
//        switch sender.tag - 100
//        {
//        case 0:
//            println()
//            let al = HWCustomAlertView(type: AlertViewType.EditNickName)
//            shareAppDelegate.window?.addSubview(al)
//            al.delegate = self
//            al.showAnimate()
//            
//        case 1:
//            println()
//            let al = HWCustomAlertView(type: AlertViewType.EditComplain)
//            shareAppDelegate.window?.addSubview(al)
//            al.delegate = self
//            al.showAnimate()
//            
//        case 2:
//            println()
//            let al = HWCustomAlertView(type: AlertViewType.HiToOther, infoDic:NSMutableDictionary())
//            shareAppDelegate.window?.addSubview(al)
//            al.delegate = self
//            al.showAnimate()
//            
//            
//        case 3:
//            println()
//            let al = HWCustomAlertView(type: AlertViewType.IsMyCustomer, alertText: NSString())
//            shareAppDelegate.window?.addSubview(al)
//            al.delegate = self
//            al.showAnimate()
//            
//        case 4:
//            println()
//            let al = HWCustomAlertView(type: AlertViewType.BindingCustomer, alertText: "10个积分")
//            shareAppDelegate.window?.addSubview(al)
//            al.delegate = self
//            al.showAnimate()
//            
//        case 5:
//            println()
//            let al = HWCustomAlertView(type: AlertViewType.CustomerUnlock, infoDic: NSMutableDictionary())
//            shareAppDelegate.window?.addSubview(al)
//            al.delegate = self
//            al.showAnimate()
//            
//        case 6:
//            println()
//            let al = HWCustomAlertView(type: AlertViewType.PassWordInput, infoDic: NSMutableDictionary())
//            shareAppDelegate.window?.addSubview(al)
//            al.delegate = self
//            al.showAnimate()
//            
//        default:
//            break
//        }
//        
//    }
    
    func didSelectdConfirm() {
        println("回调成功")
    }
    
    func ConfirmInPut(content: NSString) {
        println("回调内容：\(content)")
    }
    
    func inviteFriend()
    {
        //MYP add 埋点：我的下线－跳转邀请好友
        MobClick.event("Add referral_click")

        let vc = HWInviteViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //推出下限详情
    func didSelectedCell(id:NSString)
    {
        let vc = HWSubordinateDetailsViewController()
        vc.bID = id
//        println("brokerid ==================== \(vc.bID)")
        self.navigationController?.pushViewController(vc, animated: true)
        vc.reloadListView = { ()->Void in
           self.reloadBrokerList()
        }
    }
    
    func reloadBrokerList()
    {
        refreshView?.currentPage = 1
        refreshView?.queryListData()
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
