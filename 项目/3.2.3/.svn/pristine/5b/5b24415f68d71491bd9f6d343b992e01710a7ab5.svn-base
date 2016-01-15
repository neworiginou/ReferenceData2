//
//  HWNewScheduleViewController.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/15.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWNewScheduleViewController: HWBaseViewController, HWNewScheduleViewDelegate, HWRelateClientViewControllerDelegate, HWRelateHouseViewControllerDelegate {
    //请求之后回到客户详情
    typealias selectCustomerBlock = () ->Void
    var myFunc = selectCustomerBlock?()

    var scheduleView: HWNewScheduleView!
    var sourceType: NewScheduleSourceType = NewScheduleSourceType.New
    var editSchedule: HWScheduleModel?
    var relatedClient: HWClientModel?
    var relatedHouse: HWRelateHouseModel?
    var selectedDate: NSDate?
    var popViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (sourceType == NewScheduleSourceType.New || sourceType == NewScheduleSourceType.Appoint)
        {
            self.navigationItem.titleView = Utility.navTitleView("新建日程")
        }
        else
        {
            self.navigationItem.titleView = Utility.navTitleView("编辑日程")
        }
        
        self.navigationItem.rightBarButtonItem = Utility.navButton(self, _title: "保存", _selector: "toSaveInfo:")

        scheduleView = HWNewScheduleView(frame: CGRectMake(0, 0, kScreenWidth, contentHeight))
        scheduleView.presentViewController = self
        scheduleView.sourceType = self.sourceType
        
        if (selectedDate != nil)
        {
            scheduleView.setSelectedDate(selectedDate)
        }
        
        
        if (editSchedule != nil)
        {
            scheduleView.setEditSchedule(editSchedule!)
        }
        if (relatedClient != nil)
        {
            scheduleView.selectedClient = relatedClient
        }
        if (relatedHouse != nil)
        {
            scheduleView.selectedHouse = relatedHouse
        }
        scheduleView.delegate = self
        self.view.addSubview(scheduleView)
        
    }

    func toSaveInfo(sender: UIButton) -> Void
    {
        if (self.sourceType == NewScheduleSourceType.Edit || self.sourceType == NewScheduleSourceType.EditUpload)
        {
            scheduleView.editSaveInfo()
        }
        else
        {
            scheduleView.saveInfo()
        }
        
    }
    
    
    func relateClientViewControllerDidSelectClient(client: HWClientModel?)
    {
        scheduleView.setRelateClient(client)
    }
    
    func relateHouseViewControllerDidSelectHouse(house: HWRelateHouseModel?)
    {
        scheduleView.setRelateHouse(house)
    }
    
    func didUpdateSchedule()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension HWNewScheduleViewController:HWNewScheduleViewDelegate
{
    func didCreateNewScheduleView()
    {
        if (self.popViewController != nil)
        {
            self.navigationController?.popToViewController(self.popViewController!, animated: true)
        }
        else
        {
            self.navigationController?.popViewControllerAnimated(true)
            
            if (myFunc != nil)
            {
                myFunc!()
            }
        }
    }
    func didSelectClientWithRelatedClient(client: HWClientModel?)
    {
        let relateClientVC = HWRelateClientViewController()
        relateClientVC.delegate = self
        relateClientVC.selectedClient = client
        self.navigationController?.pushViewController(relateClientVC, animated: true)
    }
    
    func didSelectHouseWithRelatedHouse(house: HWRelateHouseModel?, clientId: NSString?)
    {
        let relateHouseVC = HWRelateHouseViewController()
        relateHouseVC.delegate = self
        relateHouseVC.selectedHouse = house
        relateHouseVC.clientId = clientId!
        self.navigationController?.pushViewController(relateHouseVC, animated: true)
    }

}
