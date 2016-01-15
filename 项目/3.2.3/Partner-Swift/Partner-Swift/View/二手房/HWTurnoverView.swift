//
//  HWTurnoverView.swift
//  Partner-Swift
//
//  Created by wuxiaohong on 15/4/14.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWTurnoverView: HWBaseRefreshView,UITextFieldDelegate {

    var arry:NSArray = NSArray()
    var moneyTextFiled = UITextField()
    var nameTextFiled = UITextField()
    var phoneTextFiled = UITextField()
    
   override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.setIsNeedHeadRefresh(false)
        self.baseTable.frame = CGRectMake(0, 0, kScreenWidth, contentHeight);
        self.baseTable.bounces = false
        self .addSubview(baseTable)
        arry = NSArray(objects:"客户姓名","手机号码")
      

    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0
        {
            return 1;
        }
        if section == 1
        {
            return 2
        }
        
        return 0;
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellId = "cellid"
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellId) as? UITableViewCell
        if(cell == nil)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellId)
        }
       
        cell?.textLabel?.font = Define.font(15)
        var textFiled = UITextField(frame: CGRectMake(100, 0, 150, 45))
        
        textFiled.font = Define.font(15)
        cell?.contentView .addSubview(textFiled)
        if indexPath.section == 0 && indexPath.row == 0
        {
            moneyTextFiled = textFiled
            moneyTextFiled.placeholder = "必填"
            textFiled.keyboardType = UIKeyboardType.NumberPad
            var lab = UILabel(frame: CGRectMake(kScreenWidth-15-50, 0, 50, 45))
            lab.textAlignment = NSTextAlignment(rawValue: 2)!
            lab.text = "万元"
            lab.textColor = CD_Txt_Color_99;
            lab.font = Define.font(15)
            cell?.addSubview(lab)
            cell?.textLabel?.text = "成交金额"
        }
        if indexPath.section == 1 && indexPath.row == 0
        {
            nameTextFiled = textFiled
            nameTextFiled.placeholder = "必填"
            cell?.textLabel?.text = "客户姓名"
        }
        if indexPath.section == 1 && indexPath.row == 1 
        {
            phoneTextFiled = textFiled
            phoneTextFiled.placeholder = "必填"
            textFiled.keyboardType = UIKeyboardType.NumberPad
            textFiled.delegate = self
            cell?.textLabel?.text = "手机号码"
        }
        cell?.drawBottomLine()
        return cell!

    }
    //MARK: UITextField的代理
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
       
        if textField == phoneTextFiled
        {
            if countElements(textField.text) >= 11 && range.length == 0
            {
                return false
            }
        }
        return true
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 45
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if section == 0
        {
            return 10
        }
        else
        {
            return 30
        }
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        if section == 0
        {
            var view = UIView(frame: CGRectMake(0, 0, kScreenWidth, 10))
            view.backgroundColor = UIColor .clearColor()
            view .drawBottomLine()
            return view
            
        }
        else
        {
            var view = UIView(frame: CGRectMake(0, 0, kScreenWidth, 30))
            view.backgroundColor = UIColor .clearColor()
            view .drawBottomLine()
            var lab = UILabel(frame: CGRectMake(15, 0, kScreenWidth, 30))
            lab.text = "客户信息（买房者）"
            lab.font = Define.font(13)
            lab.textColor = CD_Txt_Color_99
            view.addSubview(lab)
            return view
        }
        return nil
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   

}
