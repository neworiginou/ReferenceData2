//
//  HWScheduleManagerViewController.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/19.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWScheduleManagerViewController: HWBaseViewController, HWScheduleCalendarViewDelegate, HWScheduleListViewDelegate {

    var scheduleCalendarView: HWScheduleCalendarView?
    var scheduleListView: HWScheduleListView?
    typealias selectCustomerBlock = () ->Void
    var myFunc = selectCustomerBlock?()
    override func backMethod()
    {
        if (self.myFunc != nil)
        {
            self.myFunc!()
        }
        
        
        self.navigationController?.popViewControllerAnimated(true);
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBarHidden = false
        self.navigationItem.titleView = Utility.navTitleView("日程管理")
        self.navigationItem.rightBarButtonItem = Utility.navButton(self, _selector: "toAddSchedule:", _image: UIImage(named: "add_icon1")!)
        
        scheduleCalendarView = HWScheduleCalendarView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight))
        scheduleCalendarView?.delegate = self
//        let scheduleListView = HWScheduleListView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight))
        self.view.addSubview(scheduleCalendarView!)
        
    }
    func toggleScheduleToCalendarMode()
    {
        if (scheduleCalendarView == nil)
        {
            scheduleCalendarView = HWScheduleCalendarView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight))
            scheduleCalendarView?.delegate = self
            self.view.addSubview(scheduleCalendarView!)
        }

        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut)
        UIView.setAnimationDuration(1)
        UIView.setAnimationTransition(UIViewAnimationTransition.FlipFromLeft, forView: self.view, cache: true)
        self.view.bringSubviewToFront(scheduleCalendarView!)
        UIView.commitAnimations()
    }
    
    func toggleScheduleToListMode()
    {
        MobClick.event("Viewbylist_click")

        if (scheduleListView == nil)
        {
            scheduleListView = HWScheduleListView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight))
            scheduleListView?.delegate = self
            self.view.addSubview(scheduleListView!)
        }
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseInOut)
        UIView.setAnimationDuration(1)
        UIView.setAnimationTransition(UIViewAnimationTransition.FlipFromLeft, forView: self.view, cache: true)
        self.view.bringSubviewToFront(scheduleListView!)
        UIView.commitAnimations()
    }
    
    func toAddSchedule(sender: UIButton) -> Void
    {
        MobClick.event("Createschedule_click")//埋点
        let newScheduleVC = HWNewScheduleViewController()
        newScheduleVC.selectedDate = scheduleCalendarView?.selectedDate
//        newScheduleVC.myFunc = { ()->Void in
//            self.scheduleListView!.queryListData()
//        }

        self.navigationController?.pushViewController(newScheduleVC, animated: true)
    }
    
    func didSelectSchedule(schedule: HWScheduleModel?)
    {
        let scheduleDetailVC = HWScheduleDetailViewController()
        scheduleDetailVC.scheduleDetail = schedule
        scheduleDetailVC.popViewController = self
        self.navigationController?.pushViewController(scheduleDetailVC, animated: true)
    }
    
    func didSelectScheuleList(schedule: HWScheduleModel?)
    {
        let scheduleDetailVC = HWScheduleDetailViewController()
        scheduleDetailVC.scheduleDetail = schedule
        scheduleDetailVC.popViewController = self
        self.navigationController?.pushViewController(scheduleDetailVC, animated: true)
    }
    
    func uploadScheduleInfoBySchedule(schedule: HWScheduleModel?)
    {
        let newScheduleVC = HWNewScheduleViewController()
        newScheduleVC.sourceType = NewScheduleSourceType.EditUpload
        newScheduleVC.editSchedule = schedule
        self.navigationController?.pushViewController(newScheduleVC, animated: true)
    }
    
    func scheduleListUploadInfoBySchedule(schedule: HWScheduleModel?)
    {
        let newScheduleVC = HWNewScheduleViewController()
        newScheduleVC.sourceType = NewScheduleSourceType.EditUpload
        newScheduleVC.editSchedule = schedule
        self.navigationController?.pushViewController(newScheduleVC, animated: true)
    }

}
