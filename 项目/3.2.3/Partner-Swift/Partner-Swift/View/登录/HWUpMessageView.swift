//
//  HWUpMessageView.swift
//  Partner-Swift
//
//  Created by hw500028 on 15/2/27.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWUpMessageView: HWBaseRefreshView,UITextFieldDelegate {
    var passwordTF:UITextField?
    var cityLabel:UILabel?
    var nameTF:UITextField?
    var captchaTF:UITextField?
    override init(frame:CGRect)
    {
        super.init(frame: frame)
        self.baseTable.tableFooterView = footerViewFunc()
    }

    func footerViewFunc()->UIView
    {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 100))
        let messageRegisterBtn = UIButton(frame: CGRect(x: 15, y: 30, width: kScreenWidth - 30, height: 45))
        footerView.addSubview(messageRegisterBtn)
        Utility.buttonStyle(messageRegisterBtn, color: CD_Btn_MainColor, title: "短信注册")
        messageRegisterBtn.addTarget(self, action: "messageRegisterBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        return footerView
    }
    
    //MARK:---tableViewDelegate
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
     func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section
        {
        case 0:return 1;
        case 1:return 2;
        case 2:return 1;
        default:return 0
        }
    
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       switch section
       {
       case 0: return 50;
       case 1: return 30;
       case 2: return 10;
       default: return 0
        }

    }
     func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0
        {
            let hwView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 45))
            let hwlabel1 = UILabel.newAutoLayoutView()
            hwView.addSubview(hwlabel1)
            hwlabel1.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 15)
            hwlabel1.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: 10)
            hwlabel1.text = "请用注册手机号进行短信注册"
            hwlabel1.textColor = CD_Txt_Color_99
            hwlabel1.font = Define.font(TF_13)
            let hwlabel2 = UILabel.newAutoLayoutView()
            hwView.addSubview(hwlabel2)
            hwlabel2.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 15)
            hwlabel2.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: hwlabel1, withOffset: 0)
//            hwlabel2.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
            hwlabel2.autoAlignAxis(ALAxis.Vertical, toSameAxisOfView: hwlabel1)
            hwlabel2.text = "短信费用一般0.1元/条,由运营商收取"
            hwlabel2.textColor = CD_Txt_Color_99
            hwlabel2.font = Define.font(TF_13)

            return hwView
        }
        else if section == 1
        {
            let hwView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 30))
            let hwlabel1 = UILabel.newAutoLayoutView()
            hwView.addSubview(hwlabel1)
            hwlabel1.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 15)
            hwlabel1.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
            hwlabel1.text = "密码长度为6-20位字母、数字或符号"
            hwlabel1.textColor = CD_Txt_Color_99
            hwlabel1.font = Define.font(TF_13)
            return hwView
        }
        
        return nil
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let hwSection = indexPath.section
        let hwRow = indexPath.row
        let identify = "cell" + "\(hwSection)" + "\(hwRow)"
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(identify) as? UITableViewCell
            if cell == nil
            {
                cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identify)
                if hwSection == 0 && hwRow == 0
                {
                    passwordTF = UITextField.newAutoLayoutView()
                    Utility.textFeildStyle(passwordTF!, placeHoderstr: "密码", superView: cell!.contentView)
                    passwordTF!.delegate = self
                    cell?.contentView.drawTopLine()
                }
                if hwSection == 1 && hwRow == 0
                {
                    nameTF = UITextField.newAutoLayoutView()
                    Utility.textFeildStyle(nameTF!, placeHoderstr: "姓名", superView: cell!.contentView)
                    nameTF!.delegate = self
                    cell?.contentView.drawTopLine()
                }
                if hwSection == 1 && hwRow == 1
                {
                    let arrowImage = UIImageView.newAutoLayoutView()
                    cell?.contentView.addSubview(arrowImage)
                    arrowImage.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: 15)
                    arrowImage.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
                    arrowImage.autoSetDimensionsToSize(CGSize(width: 8, height: 14))
                    arrowImage.image = UIImage(named: "arrow_next")
                    cityLabel = UILabel.newAutoLayoutView()
                    cell?.contentView.addSubview(cityLabel!)
                    cityLabel?.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0), excludingEdge: ALEdge.Right)
                    cityLabel?.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Left, ofView: arrowImage)
                    cityLabel?.text = "上海"
                    cityLabel?.textColor = CD_Txt_Color_99
                    cityLabel?.font = Define.font(TF_15)
                    
                }
                
                if hwSection == 2 && hwRow == 0
                {
                    captchaTF = UITextField.newAutoLayoutView()
                    Utility.textFeildStyle(captchaTF!, placeHoderstr: "请输入邀请码", superView: cell!.contentView)
                    captchaTF!.delegate = self
                    cell?.contentView.drawTopLine()
                }
        }
        
        cell?.contentView.drawBottomLine()
        return cell!
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        self.endEditing(true)
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
