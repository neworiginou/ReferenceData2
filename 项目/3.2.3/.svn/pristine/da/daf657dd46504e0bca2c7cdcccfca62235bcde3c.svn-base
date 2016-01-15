//
//  HWAddShopController.swift
//  Partner-Swift
//
//  Created by hw500028 on 15/3/2.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

enum ControllerType
{
    case addtional
    case modify
    case addShop
    case typeNone
}

class HWAddShopController: HWBaseViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    var addshopView = HWBaseRefreshView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: contentHeight))
    var shopNameTF:UITextField?
    var shopTelTF:UITextField?
    var shopAddress:UITextField?
    var ctrlType:ControllerType?
    var loc:locationStruct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = Utility.navTitleView("添加门店")
        self.view.addSubview(addshopView)
        addshopView.baseTable.dataSource = self
        addshopView.baseTable.delegate = self
        addshopView.baseTable.tableFooterView = footerViewFunc()
        if HWLocationManager.shareManager().startLoacting() == false
        {
            Utility.showToastWithMessage("定位失败", _view: self.view)
        }
        else
        {
            HWLocationManager.shareManager().locationSuccess =
                { loction,cityNmae in
                 self.loc = loction
            }
            HWLocationManager.shareManager().locationFailure = {
            
                    Utility.showToastWithMessage("获取经纬度失败", _view: self.view)
            }
            
        }
        
    }
    //底部视图
    func footerViewFunc() -> UIView
    {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 100))
        let sureBtn = UIButton(frame: CGRect(x: 15, y: 30, width: kScreenWidth - 30, height: 45))
        Utility.buttonStyle(sureBtn, color: CD_Btn_MainColor, title: "确认")
        footerView.addSubview(sureBtn)
        sureBtn.addTarget(self, action: "sureBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        return footerView
    }
    //MARK:---tableViewDelegate
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identify = "cell\(indexPath.section)\(indexPath.row)"
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(identify) as? UITableViewCell
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)
            if indexPath.row == 0
            {
                shopNameTF = UITextField.newAutoLayoutView()
                Utility.textFeildStyle(shopNameTF!, placeHoderstr: "请输入门店名称", superView: cell!.contentView)
                shopNameTF!.delegate = self
                cell?.contentView.drawTopLine()
            }
            if indexPath.row == 1
            {
                shopTelTF = UITextField.newAutoLayoutView()
                Utility.textFeildStyle(shopTelTF!, placeHoderstr: "请输入门店联系电话", superView: cell!.contentView)
                shopTelTF?.keyboardType = UIKeyboardType.NumberPad
                shopTelTF!.delegate = self
            }
            if indexPath.row == 2
            {
                shopAddress = UITextField.newAutoLayoutView()
                Utility.textFeildStyle(shopAddress!, placeHoderstr: "请输入门店地址", superView: cell!.contentView)
                let mapBtn = UIButton.newAutoLayoutView()
                cell?.contentView.addSubview(mapBtn)
                    mapBtn.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 15), excludingEdge: ALEdge.Left)
                mapBtn.autoSetDimension(ALDimension.Width, toSize: 20)
                mapBtn.setBackgroundImage(UIImage(named: "map_1"), forState: UIControlState.Normal)
                mapBtn.addTarget(self, action: "mapBtnAction", forControlEvents: UIControlEvents.TouchUpInside)
                
            }
        }
        cell?.contentView.drawBottomLine()
        return cell!
    }
    
    func mapBtnAction()
    {
        let mapCtrl = MapLocationViewController()
        self.navigationController?.pushViewController(mapCtrl, animated: true)
        mapCtrl.clickReturnLocation = {(posizition,latitude,longtitude) -> Void
        
            in
            self.shopAddress?.text = posizition
            self.loc?.log = longtitude
            self.loc?.lat = latitude
            
        }
    }
    
    
     func scrollViewDidScroll(scrollView: UIScrollView) {
        self.view.endEditing(true)
    }

 // MARK:---action
    func sureBtnClick()
    {
        /*
        key
        orgId：***     -机构id
        storeName：*** -门店名称
        storePhone：*** -门店联系号码
        storeAddress：*** -门店地址
        longitude:*** - 位置经度
        latitude:*** - 位置纬度
        */
        
        if shopNameTF!.text.isEmpty
        {
            Utility.showToastWithMessage("门店名称不能为空", _view: view)
            return
        }
        if shopTelTF!.text.isEmpty
        {
            Utility.showToastWithMessage("电话号码能为空", _view: view)
            return
        }
        if shopAddress!.text.isEmpty
        {
            Utility.showToastWithMessage("门店地址能为空", _view: view)
            return
        }
        if (Utility.validateMobile(shopTelTF!.text!) == false)
        {
            Utility.showToastWithMessage("请输入正确的电话号码", _view: self.view)
            return
        }
        if loc == nil
        {
            Utility.showToastWithMessage("经纬度不能为空", _view: self.view)
            return
            
        }
        Utility.showMBProgress(self.view, _message: "增加中")
        var param:NSMutableDictionary = NSMutableDictionary()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject(shopNameTF!.text, forKey: "storeName")
        param.setPObject(shopTelTF!.text, forKey: "storePhone")
        param.setPObject(shopAddress!.text, forKey: "storeAddress")
        param.setPObject(HWUserLogin.currentUserLogin().orgId, forKey: "orgId")
        param.setPObject(loc!.log, forKey: "longitude")
        param.setPObject(loc!.lat, forKey: "latitude")
        var manager = HWHttpRequestOperationManager.baseManager()
            manager.postHttpRequest(kAddPartnerStore, parameters: param, queue: nil, success: { (resposeObject) -> Void in
                NSNotificationCenter.defaultCenter().postNotificationName("addShopSuccess", object: nil)
                self.navigationController?.popViewControllerAnimated(true)
                
                Utility.hideMBProgress(self.view)
                
            }) { (code, error) -> Void in
                Utility.hideMBProgress(self.view)
                Utility.showToastWithMessage(error, _view: self.view)
        }
        
    }
    
}

extension HWAddShopController:UITextFieldDelegate
{
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField == shopTelTF
        {
            if range.location >= 11 && range.length == 0
            {
                return false
            }
        }
        return true
    }
    
}

