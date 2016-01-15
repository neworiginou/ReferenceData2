//
//  HWScheduleDetailViewController.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/23.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

//2015-3-24           杨庆龙        继续跟进sourceType类型改为New

import UIKit

class HWScheduleDetailViewController: HWBaseViewController, HWScheduleDetailViewDelegate, HWCustomSiftViewDelegate {
    
    var scheduleDetail: HWScheduleModel?
    var detailView: HWScheduleDetailView!
    var popViewController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.titleView = Utility.navTitleView("日程详情")
        
        self.navigationItem.rightBarButtonItem = Utility.navButton(self, _selector: "toShowMore:", _image: UIImage(named: "more_icon")!)
        
        detailView = HWScheduleDetailView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight))
        detailView.scheduleModel = self.scheduleDetail;
        detailView.delegate = self
        self.view.addSubview(detailView)
         
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool)
    {
        detailView.queryListData()
    }
    
    func toShowMore(sender: UIButton) -> Void
    {
        let titleArr = NSArray(objects: "编辑", "完成", "删除")
        let imageArr = NSArray(objects: "editor_icon1", "editor_icon5", "editor_icon6")
        let selectView = HWCustomSiftView(title: titleArr, image:imageArr, andDependView: self.navigationItem.rightBarButtonItem?.customView)
        selectView.delegate = self
        
        if (scheduleDetail?.state.isEqualToString("0") == true)
        {
            //  未完成
        }
        else if (scheduleDetail?.state.isEqualToString("1") == true)
        {
            selectView.setInactiveButtonIndex(0)
            selectView.setInactiveButtonIndex(1)
        }
        selectView.showInView(shareAppDelegate.window)
    }
    
    func siftView(siftView: HWCustomSiftView!, didSelectedIndex index: Int)
    {
        if (index == 0)
        {
            //  编辑
            let newScheduleVC: HWNewScheduleViewController = HWNewScheduleViewController()
            newScheduleVC.sourceType = NewScheduleSourceType.Edit
            newScheduleVC.editSchedule = scheduleDetail
            self.navigationController?.pushViewController(newScheduleVC, animated: true)
        }
        else if (index == 1)
        {
            if (self.scheduleDetail?.clientInfoId.length > 0 && (self.scheduleDetail?.longitude.length == 0 || self.scheduleDetail?.latitude.length == 0 || self.scheduleDetail?.picKey.length == 0))
            {
                // 有业务的日程  提示
                let alert = UIAlertView(title: "提示", message: "上传现场图片和位置？", delegate: nil, cancelButtonTitle: "取消", otherButtonTitles: "暂不","上传")
                alert.showAlertViewWithCompleteBlock({ (buttonIndex) -> Void in
                    if (buttonIndex == 1)
                    {
                        self.requestDoneByScheduleIsUpload(false)
                    }
                    else if (buttonIndex == 2)
                    {
                        MobClick.event("SubmitLOC&IMG_click")
                        let newScheduleVC = HWNewScheduleViewController()
                        newScheduleVC.sourceType = NewScheduleSourceType.EditUpload
                        newScheduleVC.editSchedule = self.scheduleDetail
                        self.navigationController?.pushViewController(newScheduleVC, animated: true)
                    }
                })
            }
            else
            {
                self.requestDoneByScheduleIsUpload(false)
            }
            
            // 完成
            /*
            id:*** - 日程id,
            operType: *** （1延时，2完成，3删除）
            delayTime: *** -延时时间[yyyy-MM-dd HH:mm:ss]
            */
            
            
        }
        else if (index == 2)
        {
            // 删除
            /*
            id:*** - 日程id,
            operType: *** （1延时，2完成，3删除）
            delayTime: *** -延时时间[yyyy-MM-dd HH:mm:ss]
            */
            
            Utility.showMBProgress(self.view, _message: "发送数据")
            
            let manager: HWHttpRequestOperationManager = HWHttpRequestOperationManager.baseManager()
            
            var param: NSMutableDictionary! = NSMutableDictionary()
            param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
            param.setPObject(scheduleDetail?.partnerScheduleId, forKey: "id")
            param.setPObject("3", forKey: "operType")
            manager.postHttpRequest(kScheduleStatusUpdate, parameters: param, queue: nil, success: { (responseObject) -> Void in
                
                NSNotificationCenter.defaultCenter().postNotificationName("ScheduleViewSaveSuccess", object: nil)
                Utility.hideMBProgress(self.view)
                Utility.showToastWithMessage("操作成功", _view: shareAppDelegate.window!)
                // 删除成功
                self.navigationController?.popViewControllerAnimated(true)
                
                }, failure: { (code, error) -> Void in
                    Utility.hideMBProgress(self.view)
                    Utility.showToastWithMessage(error, _view: self.view)
                })
        }
    }
    
    func requestDoneByScheduleIsUpload(isUpload: Bool)
    {
        Utility.showMBProgress(self.view, _message: "发送数据")
        
        let manager: HWHttpRequestOperationManager = HWHttpRequestOperationManager.baseManager()
        
        var param: NSMutableDictionary! = NSMutableDictionary()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject(scheduleDetail?.partnerScheduleId, forKey: "id")
        param.setPObject("2", forKey: "operType")
        
        if (isUpload == true)
        {
            param.setPObject("1", forKey: "finishType")
        }
        else
        {
            param.setPObject("0", forKey: "finishType")
        }
        
        
        manager.postHttpRequest(kScheduleStatusUpdate, parameters: param, queue: nil, success: { (responseObject) -> Void in
        
            Utility.hideMBProgress(self.view)
            Utility.showToastWithMessage("操作成功", _view: self.view)
            self.scheduleDetail?.state = "1"
        
        }, failure: { (code, error) -> Void in
            Utility.hideMBProgress(self.view)
            Utility.showToastWithMessage(error, _view: self.view)
        })

    }
    
    func didSelectContinueFollow()
    {
        let newScheduleVC: HWNewScheduleViewController = HWNewScheduleViewController()
        newScheduleVC.sourceType = NewScheduleSourceType.New
        
        var schedule: HWScheduleModel = HWScheduleModel()
        schedule.clientInfoId = scheduleDetail?.clientInfoId
        schedule.clientName = scheduleDetail?.clientName
        schedule.clientPhone = scheduleDetail?.clientPhone
        schedule.houseBrokerName = scheduleDetail?.houseBrokerName
        schedule.houseBrokerPhone = scheduleDetail?.houseBrokerPhone
        schedule.houseId = scheduleDetail?.houseId
        schedule.houseName = scheduleDetail?.houseName
        schedule.houseType = scheduleDetail?.houseType
        
        newScheduleVC.editSchedule = schedule
        
        if (self.popViewController != nil)
        {
            newScheduleVC.popViewController = self.popViewController;
        }
        
        newScheduleVC.myFunc = { ()->Void in
            self.navigationController?.popViewControllerAnimated(false)
            return
        }
        
        self.navigationController?.pushViewController(newScheduleVC, animated: true)
    } 
    
    func didSelectClientInfo(schedule: HWScheduleModel?)
    {
        if (schedule == nil)
        {
            return
        }
        
        if schedule!.sourceWay == "broker_to_client"
        {
            let agentVC = HWAgentCutomerVC()
            agentVC.clientInfoId = self.scheduleDetail?.clientInfoId as String
            navigationController?.pushViewController(agentVC, animated: true)

        }
        else
        {
            let clientDetailVC = HWCustomerDetailViewController()
            clientDetailVC.clientInfoId = self.scheduleDetail?.clientInfoId as String
            self.navigationController?.pushViewController(clientDetailVC, animated: true)

        }
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
