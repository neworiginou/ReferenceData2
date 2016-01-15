//
//  HWSetPasswordTableView.swift
//  Partner-Swift
//
//  Created by hw500028 on 15/2/28.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit
protocol HWSetPasswordViewDelegate:NSObjectProtocol
{
    func SetPasswordViewCompleteBtnClick() -> Void
}
class HWSetPasswordView: HWBaseRefreshView,UITextFieldDelegate {
    var setPasswordTF:UITextField?
    var delegate:HWSetPasswordViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.baseTable.tableFooterView = footerViewFunc()
        self.setIsNeedHeadRefresh(false)
    }

 
    func footerViewFunc() -> UIView
    {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 100))
        let hwlabel = UILabel.newAutoLayoutView()
        footerView.addSubview(hwlabel)
        hwlabel.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: 10)
        hwlabel.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 15)
        hwlabel.text = "密码长度6-20位字母、数字或符号"
        hwlabel.textColor = CD_Txt_Color_99
        hwlabel.font = Define.font(TF_13)
        
        //
        let completeBtn = UIButton.newAutoLayoutView()
        footerView.addSubview(completeBtn)
        completeBtn.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: hwlabel, withOffset: 20)
        completeBtn.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        completeBtn.autoSetDimensionsToSize(CGSize(width: kScreenWidth - 30, height: 45))
        Utility.buttonStyle(completeBtn, color: CD_Btn_MainColor, title: "完成")
        completeBtn.addTarget(self, action: "completeAction", forControlEvents: UIControlEvents.TouchUpInside)
        return footerView
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
     func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
     func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identify = "cell\(indexPath.section)\(indexPath.row)"
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(identify) as? UITableViewCell
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)
            setPasswordTF = UITextField.newAutoLayoutView()
            Utility.textFeildStyle(setPasswordTF!, placeHoderstr: "设置密码", superView: cell!.contentView)
            setPasswordTF!.delegate = self
        }
        cell?.contentView.drawBottomLine()
        cell?.contentView.drawTopLine()
        return cell!
    }
    
    //MARK:---action
    func completeAction() -> Void
    {
        if (delegate != nil && delegate?.respondsToSelector("SetPasswordViewCompleteBtnClick") != false)
        {
            delegate?.SetPasswordViewCompleteBtnClick()
        }
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
