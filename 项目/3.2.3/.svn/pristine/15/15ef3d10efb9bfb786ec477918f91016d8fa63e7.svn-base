//
//  HWScdHouLinkCustomVC.swift
//  Partner-Swift
//
//  Created by niedi on 15/3/9.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：二手房 关联客户页面
//
//  修改记录：
//      姓名         日期               修改内容
//      聂迪      2015-02-26           功能实现
//

import UIKit

protocol ScdHouLinkCustomVCDelegate: NSObjectProtocol
{
    func linkCustomSelected(customModel: HWClientModel)
}

class HWScdHouLinkCustomVC: HWBaseViewController, HWCustomerSearchDelegate, HWCustomerInfoViewDelegate
{
    //MARK: 成员变量
    var isMultipleChoice: Bool! = false     //单选/多选 对应预约看房或关联客户
    var houseId: String! = ""
    var houseName: String! = ""
    var selectedClient: HWClientModel?
    var delegate: ScdHouLinkCustomVCDelegate!
    
    var customerTableV: HWCustomerInfoView!
    var houseNameLab: UILabel!
    var chosenCustomNumLab: UILabel!
    var chosenCustomArr: NSArray? = []
    
    //MARK: viewDidLoad
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.titleView = Utility.navTitleView("选择客户")
        self.navigationItem.rightBarButtonItem = Utility.navButton(self, _title: "添加", _selector: "pushToLoggingCustomVC")
        
        if(isMultipleChoice == true)
        {
            customerTableV = HWCustomerInfoView(frame: CGRectMake(0, 55, kScreenWidth, contentHeight - 55 - 57));
            customerTableV.selectMode = ClientSelectMode.Multiplicity
        }
        else
        {
            customerTableV = HWCustomerInfoView(frame: CGRectMake(0, 55, kScreenWidth, contentHeight - 55));
            customerTableV.selectMode = ClientSelectMode.Single
        }
        customerTableV.delegate = self
        customerTableV.sourceMode = ClientSource.SecondHouseRelate
        customerTableV.houseId = self.houseId
        if (selectedClient != nil)
        {
            customerTableV.selectedArray = NSMutableArray(object: selectedClient!)
        }
        self.view.addSubview(customerTableV);
        
        var searchView: HWCustomerSearchView = HWCustomerSearchView(frame: CGRectMake(0, 0, kScreenWidth, 55),type:"0");
        searchView.delegate = self;
        self.view.addSubview(searchView);
        self.view.backgroundColor = UIColor.whiteColor();
        
        if(isMultipleChoice == true)
        {
            var backView = UIView(frame: CGRectMake(0, contentHeight - 57, kScreenWidth, 57))
            backView.backgroundColor = "#7a7a7a".UIColor
            self.view.addSubview(backView)
            
            houseNameLab = UILabel(frame: CGRectMake(15, 9, kScreenWidth - 15 - 125, 16))
            houseNameLab.font = Define.font(TF_16)
            houseNameLab.textColor = CD_WhiteColor
            houseNameLab.text = houseName
            backView.addSubview(houseNameLab)
            
            chosenCustomNumLab = UILabel(frame: CGRectMake(15, houseNameLab.frame.maxY + 5, houseNameLab.frame.width, 15))
            backView.addSubview(chosenCustomNumLab)
            
            var confirmBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
            confirmBtn.frame = CGRectMake(kScreenWidth - 125, 10, 110, 35)
            confirmBtn.layer.cornerRadius = 3
            confirmBtn.clipsToBounds = true
            confirmBtn.setTitle("确定", forState: UIControlState.Normal)
            confirmBtn.titleLabel?.font = Define.font(TF_Btn_Title_19)
            confirmBtn.setBackgroundImage(Utility.imageWithColor(CD_Btn_MainColor, _size: confirmBtn.frame.size), forState: UIControlState.Normal)
            confirmBtn.addTarget(self, action: "publishChosenCustomBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
            backView.addSubview(confirmBtn)
            
            self.changeChosenCustomNum()
        }
    }
    
    //HWCustomerInfoView 客户列表cell点击事件
    func didSelectedCustomer(customerArr: NSArray?)
    {
        if(isMultipleChoice == true)
        {
            if(customerArr != nil)
            {
                chosenCustomArr = customerArr
            }
            self.changeChosenCustomNum()
        }
        else
        {
            var client: HWClientModel? = customerArr?.pObjectAtIndex(0) as? HWClientModel
            if(client != nil)
            {
                delegate.linkCustomSelected(client!)
            }
            self.navigationController?.popViewControllerAnimated(true)
        }
        
    }
    
    //MARK: 更改已选择客户数量
    func changeChosenCustomNum()
    {
        chosenCustomNumLab.attributedText = self.setAttributeString("\(chosenCustomArr!.count)")
    }
    
    //MARK: 提交
    func publishChosenCustomBtnClick()
    {
        if(chosenCustomArr?.count == 0)
        {
            Utility.showToastWithMessage("未选择要关联的客户", _view: self.view)
//            self.navigationController?.popViewControllerAnimated(true)
        }
        else
        {
            /*url:/MyHousesInfo/associatedClientHouse.do
            入参：
            clientInfoIds:*** --客户ID(多个用逗号隔开)
            scdhandHousesId：*** --二手房ID
            
            出参：
            { "detail": "请求数据成功!", "status": "1", "data": "操作成功" } */
            Utility.hideMBProgress(self.view)
            Utility.showMBProgress(self.view, _message: "上传中")
            
            let manager = HWHttpRequestOperationManager.baseManager()
            var param = NSMutableDictionary()
            
            param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
            param.setPObject(houseId, forKey: "scdhandHousesId")
            
            var tmpStr = ""
            for var i = 0; i < chosenCustomArr!.count; i++
            {
                var tmpModel = chosenCustomArr![i] as HWClientModel
                tmpStr = "\(tmpStr)\(tmpModel.clientInfoId),"
            }
            if(countElements(tmpStr) > 0)
            {
                
                tmpStr = tmpStr.substringToIndex(advance(tmpStr.endIndex, -1))
            }
            param.setPObject(tmpStr, forKey: "clientInfoIds")
            
            manager.postHttpRequest(kScdHouLinkCustom, parameters: param, queue: nil, success: { (responseObject) -> Void in
                
                Utility.hideMBProgress(self.view)
                Utility.showToastWithMessage("关联成功", _view: self.view)
                self.navigationController?.popViewControllerAnimated(true)
                
                }) { (code, error) -> Void in
                    
                    Utility.hideMBProgress(self.view)
                    
                    Utility.showToastWithMessage(error, _view: self.view)
            }
        }
    }
    
    //MARK: 添加客户点击事件
    func pushToLoggingCustomVC()
    {
        var logginCustomerV:HWLoggingCustomerVC = HWLoggingCustomerVC();
        logginCustomerV.titileType = "0"
        logginCustomerV.agentClientModel == Optional.None
        logginCustomerV.myFunc = { ()->Void in
            self.customerTableV.currentPage = 1
            self.customerTableV.secondHouseQueryListData()
        }
        self.navigationController?.pushViewController(logginCustomerV, animated: true);
    }
    
    //MAKE:-实时搜索
    func didSearchTitle(title: NSString)
    {
        print(title);
        customerTableV.setSearchKey(title)
    }
    
    //MAKE:-选择分类筛选
    func didSelectMenuByIndex(index: NSInteger)
    {
        print(title);
        customerTableV.setSearchFilterIndex(index)
    }
    func didSelectMenufirstIdAndSecondId(first: NSString, second: NSString) {
        
    }
    //MAKE:-过滤结束
    func didMenuEnd()->Void
    {
        //        customerTableV.hidden = false;
    }
    //MAKE:-过滤开始
    func didMenuStart()->Void
    {
        //        customerTableV.hidden = true;
    }
    
    
    //MARK: 更改字体属性 setAttributeString
    private func setAttributeString(ContentForLab: String) -> NSAttributedString
    {
        var attributeStr = NSMutableAttributedString(string: "已选择匹配客户: \(ContentForLab) 人")
        attributeStr.addAttributes([NSFontAttributeName : Define.font(TF_14)], range: NSMakeRange(0, countElements(ContentForLab) + 11))
        attributeStr.addAttributes([NSForegroundColorAttributeName : "#cccccc".UIColor], range: NSMakeRange(0, 9))
        attributeStr.addAttributes([NSForegroundColorAttributeName: CD_Txt_MainColor], range: NSMakeRange(9, countElements(ContentForLab)))
        attributeStr.addAttributes([NSForegroundColorAttributeName: "#cccccc".UIColor], range: NSMakeRange(9 + countElements(ContentForLab), 2))
        
        return attributeStr
    }
    
}
