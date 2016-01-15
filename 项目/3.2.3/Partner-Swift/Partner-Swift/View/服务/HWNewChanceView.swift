//
//  HWNewChanceView.swift
//  Partner-Swift
//
//  Created by hw500027 on 15/2/5.
//  Copyright (c) 2015年 luxiaobo. All rights reserved.
//
//  功能描述：机会详情列表
//
//  修改记录：
//      姓名         日期              修改内容
//    陆晓波      2015-02-12           文件创建
//

import UIKit

protocol HWNewChanceViewDelegate:NSObjectProtocol
{
    func didSelectedSubmitBtn(productName:NSString!,customerName:NSString!,loan:NSString?)
    func toChooseCustomerList()
}

class HWNewChanceView: HWBaseRefreshView,HWServiceCustomPickViewDelegate,HWNewChanceCellDelegate {
    
    weak var newChanceViewDelegate:HWNewChanceViewDelegate?
    
    var textLabelStr:NSString? = "选择服务产品"
    var customerLabelStr:NSString? = "选择客户"
    var loan:NSString? = "输入金额"
    
    var _customerModel:HWClientModel?
    var _model:HWServiceProductModel?
    var _cell:HWNewChanceCell!
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.setIsNeedHeadRefresh(false)

        var headerView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 10 * kRate))
        headerView.drawBottomLine()
        self.baseTable.tableHeaderView = headerView
        self.baseTable.registerClass(HWNewChanceCell.self, forCellReuseIdentifier: "cell")
        self.baseTable.registerClass(HWNewChanceCell.self, forCellReuseIdentifier: "cell1")
        self.queryListData()
    }
    
    override func queryListData()
    {
        //加载服务产品
        Utility.hideMBProgress(self)
        Utility.showMBProgress(self, _message: "请求数据")
        
        let manager = HWHttpRequestOperationManager.baseManager()
        var param = NSMutableDictionary()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject("\(currentPage)", forKey: "pageNumber")
        param.setPObject("\(kPageCount)", forKey: "pageSize")
        
        manager.postHttpRequest(kServiceProductList, parameters: param, queue: nil, success:
            { (responseObject) -> Void in
                Utility.hideMBProgress(self)
                var dataArray : NSArray = responseObject.arrayObjectForKey("data")
                if (dataArray.count < kPageCount)
                {
                    self.isLastPage = true
                }
                else
                {
                    self.isLastPage = false
                }
                if (self.currentPage == 1)
                {
                    self.baseListArr.removeAllObjects()
                }
                
                for dica in dataArray
                {
                    let model = HWServiceProductModel(dic: dica as NSDictionary)
                    self.baseListArr.addObject(model)
                }
                self.baseTable.reloadData()
                self.doneLoadingTableViewData()
                if (self.baseListArr.count == 0)
                {
                    self.showEmptyView("暂无客户")
                }
                else
                {
                    self.hideEmptyView()
                }
            })
            { (code, error) -> Void in
                Utility.hideMBProgress(self)
                self.doneLoadingTableViewData()
                if (self.baseListArr.count == 0 && code.integerValue == kStatusFailure)
                {
                    self.showNetworkErrorView(kFailureDetail)
                }
                else
                {
                    Utility.showToastWithMessage(error, _view: self)
                }
        }
    }
    
    func setCustomerModel(model:HWClientModel)
    {
        _customerModel = model
        customerLabelStr = _customerModel!.clientName
        self.baseTable.reloadData()
    }
    
    //MARK:--tableView delegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 44 * kRate
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if (indexPath.section == 0 && indexPath.row == 0)
        {
            _cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as HWNewChanceCell
            _cell._titleLabel?.text = "服务产品"
            _cell._detailLabel?.text = textLabelStr
            if (textLabelStr != "选择服务产品")
            {
                _cell._detailLabel.textColor = CD_Txt_Color_00
            }
            else
            {
                _cell._detailLabel.textColor = CD_Txt_Color_99
            }
        }
        else if (indexPath.section == 0 && indexPath.row == 1)
        {
            _cell = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath) as HWNewChanceCell
            _cell.newChanceCellDelegate = self
            if (_model?.chanceType == "financial")
            {
                _cell._titleLabel?.text = "需求金额"
                _cell.addLoan()
                _cell._textField.text = loan
                if (loan != "输入金额")
                {
                    _cell._textField.textColor = CD_Txt_Color_00
                }
                else
                {
                    _cell._textField.textColor = CD_Txt_Color_99
                }
            }
        }
        else if (indexPath.section == 1 && indexPath.row == 0)
        {
            _cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as HWNewChanceCell
            _cell._titleLabel?.text = "姓名"
            _cell._detailLabel?.text = customerLabelStr
            if (customerLabelStr != "选择客户")
            {
                _cell._detailLabel.textColor = CD_Txt_Color_00
            }
            else
            {
                _cell._detailLabel.textColor = CD_Txt_Color_99
            }
        }
        _cell.contentView.drawBottomLine()
        return _cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if indexPath.section == 0 && indexPath.row == 0
        {
            var pickView = HWServiceCustomPickerView(dataArray: self.baseListArr, str: "0")
            pickView.customPickerViewDelegate = self
            self.addSubview(pickView)
        }
        else if indexPath.section == 1 && indexPath.row == 0
        {
            newChanceViewDelegate?.toChooseCustomerList()//clientInfoId
            
            //self.baseTable.reloadData()
            
            println("选择客户列表") 
        }
    }
    
    //MARK:--选择器代理
    func passSelectedItem(model: HWServiceProductModel)
    {
        _model = model
        textLabelStr = _model?.productName
        self.baseTable.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if _model?.chanceType == "financial"
        {
            if section == 0
            {
                return 2
            }
        }
        return 1
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        if section == 0
        {
            return 90 * kRate
        }
        else if section == 1
        {
            return 65 * kRate
        }
        return 0
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        if section == 0
        {
            var headerView:UIView! = UIView(frame: CGRectMake(0, 0, kScreenWidth, 90 * kRate))
            
            //服务说明
            var productIntroductionLabel = UILabel(forAutoLayout: ())
            productIntroductionLabel.numberOfLines = 0
            productIntroductionLabel.textColor = CD_Txt_Color_99
            productIntroductionLabel.font = Define.font(TF_13)
            headerView.addSubview(productIntroductionLabel)
            productIntroductionLabel.text = "服务说明：我们的服务人员会主动与您取得联系客户签约服务后，您将获得一笔可观的的推荐费。"
            
            productIntroductionLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: headerView, withOffset: 12 * kRate)
            productIntroductionLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: headerView, withOffset: serviceCustomerCell_offset_15 * kRate)
            productIntroductionLabel.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: headerView, withOffset: -serviceCustomerCell_offset_15 * kRate)
            
            //客户信息
            var customerInfoLabel = UILabel(forAutoLayout: ())
            customerInfoLabel.font = Define.font(TF_13)
            customerInfoLabel.text = "客户信息"
            customerInfoLabel.textColor = CD_Txt_Color_99
            headerView.addSubview(customerInfoLabel)
            
            customerInfoLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: productIntroductionLabel)
            customerInfoLabel.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Bottom, ofView: headerView, withOffset: -serviceCustomerCell_offset_10 * kRate)
            
            headerView.drawBottomLine()

            return headerView
        }
        else if section == 1
        {
            var footerView:UIView! = UIView(frame: CGRectMake(0, 0, kScreenWidth, 65))
            
            var submitBtn = UIButton(forAutoLayout: ())
            submitBtn.layer.masksToBounds = true
            submitBtn.layer.cornerRadius = 3
            footerView.addSubview(submitBtn)
            submitBtn.setTitle("提交", forState: UIControlState.Normal)
            if (textLabelStr != "选择服务产品" && customerLabelStr != "选择客户" )
            {
                if(_model?.chanceType == "financial") &&  (loan == "" || loan == "输入金额")
                   
                {
                    submitBtn.setBackgroundImage(Utility.imageWithColor(CD_Btn_GrayColor, _size: CGSizeMake(kScreenWidth, 65)), forState: UIControlState.Normal)
                    submitBtn.setBackgroundImage(Utility.imageWithColor(CD_Btn_GrayColor_Clicked, _size: CGSizeMake(kScreenWidth, 65)), forState: UIControlState.Highlighted)
                }
              else  if(_model?.chanceType == "financial") &&  (loan != "" || loan != "输入金额")
                {
                    submitBtn.setBackgroundImage(Utility.imageWithColor(CD_Btn_MainColor, _size: CGSizeMake(kScreenWidth, 65)), forState: UIControlState.Normal)
                    submitBtn.setBackgroundImage(Utility.imageWithColor(CD_Btn_MainColor_Clicked, _size: CGSizeMake(kScreenWidth, 65)), forState: UIControlState.Highlighted)
                    submitBtn.addTarget(self, action: "submitNewChance", forControlEvents: UIControlEvents.TouchUpInside)
                }
                    
                else
                {
                    submitBtn.setBackgroundImage(Utility.imageWithColor(CD_Btn_MainColor, _size: CGSizeMake(kScreenWidth, 65)), forState: UIControlState.Normal)
                    submitBtn.setBackgroundImage(Utility.imageWithColor(CD_Btn_MainColor_Clicked, _size: CGSizeMake(kScreenWidth, 65)), forState: UIControlState.Highlighted)
                    submitBtn.addTarget(self, action: "submitNewChance", forControlEvents: UIControlEvents.TouchUpInside)
                }
            }
            else
            {
                submitBtn.setBackgroundImage(Utility.imageWithColor(CD_Btn_GrayColor, _size: CGSizeMake(kScreenWidth, 65)), forState: UIControlState.Normal)
                submitBtn.setBackgroundImage(Utility.imageWithColor(CD_Btn_GrayColor_Clicked, _size: CGSizeMake(kScreenWidth, 65)), forState: UIControlState.Highlighted)
            }
            
            submitBtn.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: footerView, withOffset: serviceCustomerCell_offset_10 * kRate)
            submitBtn.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: footerView, withOffset: -serviceCustomerCell_offset_10 * kRate)
            submitBtn.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: footerView, withOffset: serviceCustomerCell_offset_20 * kRate)
            submitBtn.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Bottom, ofView: footerView, withOffset: 0)

            return footerView
        }
        return Optional.None
    }
    
    //MARK:--cell代理
    func didReturnKeyBoard(textFieldStr: NSString?)
    {
        loan = textFieldStr
        self.baseTable.reloadData()
    }
    
    //MARK:--实现 点击 提交新建机会按钮
    func submitNewChance()
    {
        //如果服务产品为金融类型，判断输入金融格式
        if (_model?.chanceType == "financial")
        {
            if (Utility_OC.isPureFloat(loan) && Utility_OC.isPureInt(loan))
            {
                //请求新建机会接口
                self.queryNewChance(true)
            }
            else
            {
                Utility.showToastWithMessage("请输入正确的金额", _view: self)
            }
        }
        else
        {
            //请求新建机会接口
            self.queryNewChance(false)
        }
    }
    
    func queryNewChance(isFinancial:Bool)
    {
        let manager = HWHttpRequestOperationManager.baseManager()
        var param = NSMutableDictionary()
        param.setPObject(HWUserLogin.currentUserLogin().key, forKey: "key")
        param.setPObject(_customerModel!.clientInfoId, forKey: "clientInfoId")
        param.setPObject(_model?.chanceTypeId, forKey: "chanceTypeId")
        param.setPObject(_model?.serviceProductId, forKey: "serviceProductId")
        if (isFinancial == true)
        {
            param.setPObject(loan, forKey: "loan")
        }
        
        manager.postHttpRequest(kSaveChance, parameters: param, queue: nil, success:
        { (responseObject) -> Void in
            if (responseObject.stringObjectForKey("status") == "1")
            {
                self.newChanceViewDelegate?.didSelectedSubmitBtn(self.textLabelStr, customerName: self.customerLabelStr, loan: self.loan)
            }
        })
        { (code, error) -> Void in
            Utility.showToastWithMessage(error, _view: self)
        }
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
