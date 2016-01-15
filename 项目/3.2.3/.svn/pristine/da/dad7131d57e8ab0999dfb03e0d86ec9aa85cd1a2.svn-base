//
//  HWChanceDetailView.swift
//  Partner-Swift
//
//  Created by hw500027 on 15/2/10.
//  Copyright (c) 2015年 luxiaobo. All rights reserved.
//
//  功能描述：服务首页-机会详情列表
//
//  修改记录：
//      姓名         日期              修改内容
//    陆晓波      2015-02-10           文件创建
//    陆晓波      2015-02-28           模拟数据

import UIKit

class HWChanceDetailView: HWBaseRefreshView {
    
    var _chanceDetailModel:HWServiceCustomerModel?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.setIsNeedHeadRefresh(false)
        
        var headerView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 10 * kRate))
        headerView.drawBottomLine()
        self.baseTable.tableHeaderView = headerView
        self.baseTable.registerClass(HWChanceDetailCell.self, forCellReuseIdentifier: "cell")
    }

    //MARK:--tableView delegate
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0
        {
            //类型是权证，列表行数为3。金融，为4
            return _chanceDetailModel?.chanceType == "warrant" ? 3 : 4
        }
        else if section == 1
        {
            return 1
        }
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 44 * kRate
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 2
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as HWChanceDetailCell
        if (indexPath.section == 0)
        {
            if (indexPath.row == 0)
            {
                cell._titleLabel.text = "服务类型"
                if (_chanceDetailModel?.chanceType == "warrant")
                {
                    cell._detailLabel.text = "权证"
                }
                else
                {
                    cell._detailLabel.text = "金融"
                }
            }
            else if (indexPath.row == 1)
            {
                cell._titleLabel.text = "服务产品"
                cell._detailLabel.text = _chanceDetailModel?.productName
            }
            else if (indexPath.row == 2)
            {
                if (_chanceDetailModel?.chanceType == "warrant")
                {
                    cell._titleLabel.text = "状态"
                    cell.changeTextColor(_chanceDetailModel!)
                    
                }
                else if (_chanceDetailModel?.chanceType == "financial")
                {
                    cell._titleLabel.text = "金额"
                    cell._detailLabel.text = _chanceDetailModel?.loan
                }
            }
            else if (indexPath.row == 3)
            {
                if (_chanceDetailModel?.chanceType == "financial")
                {
                    cell._titleLabel.text = "状态"
                    cell.changeTextColor(_chanceDetailModel!)
                }
            }
        }
        else if (indexPath.section == 1)
        {
            cell._titleLabel.text = "姓名"
            cell._detailLabel.text = _chanceDetailModel?.name
        }
        cell.contentView.drawBottomLine()
        return cell
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        if section == 0
        {
            return 30 * kRate
        }
        return 0
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        if section == 0
        {
            let backgroundView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 30 * kRate))
            backgroundView.drawBottomLine()
            
            let customerInfoLabel = UILabel(forAutoLayout: ())
            customerInfoLabel.text = "客户信息"
            customerInfoLabel.textColor = CD_Txt_Color_99
            customerInfoLabel.font = Define.font(TF_13)
            backgroundView.addSubview(customerInfoLabel)
            
            customerInfoLabel.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Bottom, ofView: backgroundView, withOffset: -8 * kRate)
            customerInfoLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: backgroundView, withOffset: serviceCustomerCell_offset_15 * kRate)
            customerInfoLabel.autoSetDimension(ALDimension.Height, toSize: TF_13)
            
            return backgroundView
        }
        return nil
    }
    
    required init(coder aDecoder: NSCoder) {
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
