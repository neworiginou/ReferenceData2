//
//  HWSubmitSuccessView.swift
//  Partner-Swift
//
//  Created by hw500027 on 15/2/10.
//  Copyright (c) 2015年 luxiaobo. All rights reserved.
//
//  功能描述：提交成功列表
//
//  修改记录：
//      姓名         日期              修改内容
//    陆晓波      2015-02-12           文件创建
//

import UIKit

protocol HWSubmitSuccessViewDelegate:NSObjectProtocol
{
    func didSelectedBackToServiceList()
}

class HWSubmitSuccessView: HWBaseRefreshView {

    weak var submitSuccessDelegate:HWSubmitSuccessViewDelegate?

    var productName:NSString?
    var customerName:NSString?
    var loan:NSString?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setIsNeedHeadRefresh(false)
        //self.backgroundColor = CD_BackGroundColor
        
        self.baseTable.registerClass(HWSubmitSuccessCell.self, forCellReuseIdentifier: "cell")
        //成功提交信息headerView
        let headerView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 150 * kRate))
        headerView.drawBottomLine()
        self.baseTable.tableHeaderView = headerView
        
        //headerView上的成功提交图片
        var successImageView = UIImageView(forAutoLayout: ())
        successImageView.image = UIImage(named: "success")
        headerView.addSubview(successImageView)
        successImageView.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: headerView, withOffset: 35 * kRate)
        successImageView.autoAlignAxis(ALAxis.Vertical, toSameAxisOfView: headerView)
        
        //headerView上的显示文字信息
        var successLabel = UILabel(forAutoLayout: ())
        successLabel.font = Define.font(TF_16)
        successLabel.textColor = CD_MainColor
        successLabel.text = "您已经提交客户信息!"
        headerView.addSubview(successLabel)
        
        successLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: successImageView, withOffset: 18 * kRate)
        successLabel.autoAlignAxis(ALAxis.Vertical, toSameAxisOfView: headerView)
        
    }
    
    //MARK:--tableView delegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 44 * kRate
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (loan != "输入金额")
        {
            return 3
        }
        return 2
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as HWSubmitSuccessCell
        if indexPath.section == 0
        {
            if indexPath.row == 0
            {
                cell._titleLabel.text = "服务产品"
                cell._detailLabel.text = productName
            }
            else if indexPath.row == 1
            {
                cell._titleLabel.text = "姓名"
                cell._detailLabel.text = customerName
            }
            else if (indexPath.row == 2)
            {
                cell._titleLabel.text = "金额"
                cell._detailLabel.text = loan
            }
            cell.contentView.drawBottomLine()
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        if section == 0
        {
            return 140 * kRate
        }
        return 0
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        let footerView = UIView(frame: CGRectMake(0, 0, kScreenWidth, 140 * kRate))
        
        let backInfoLabel1 = UILabel(forAutoLayout: ())
        backInfoLabel1.text = "我们的服务人员会主动与您取得联系"
        backInfoLabel1.font = Define.font(TF_13)
        backInfoLabel1.textColor = CD_Txt_Color_99
        footerView.addSubview(backInfoLabel1)
        
        let backInfoLabel2 = UILabel(forAutoLayout: ())
        backInfoLabel2.text = "您可以在客户列表中查看状态信息。"
        backInfoLabel2.font = Define.font(TF_13)
        backInfoLabel2.textColor = CD_Txt_Color_99
        footerView.addSubview(backInfoLabel2)
        
        //返回列表按钮
        let backButton = UIButton(forAutoLayout: ())
        backButton.titleLabel?.font = Define.font(TF_19)
        backButton.layer.masksToBounds = true
        backButton.layer.cornerRadius = 3
        backButton.setTitle("返回客户列表", forState: UIControlState.Normal)
        backButton.addTarget(self, action: "backToVC", forControlEvents: UIControlEvents.TouchUpInside)
        footerView.addSubview(backButton)
        
        backInfoLabel1.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: footerView, withOffset: 13 * kRate)
        backInfoLabel1.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: footerView, withOffset: serviceCustomerCell_offset_15 * kRate)
        backInfoLabel1.autoSetDimension(ALDimension.Height, toSize: TF_13 * kRate)
        
        backInfoLabel2.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: backInfoLabel1)
        backInfoLabel2.autoSetDimension(ALDimension.Height, toSize: TF_13 * kRate)
        backInfoLabel2.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: backInfoLabel1, withOffset: 35 * kRate)
        
        backButton.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: backInfoLabel2, withOffset: 19 * kRate)
        backButton.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: backInfoLabel1)
        backButton.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: footerView, withOffset: -serviceCustomerCell_offset_15 * kRate)
        backButton.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Bottom, ofView: footerView)

        backButton.setBackgroundImage(Utility.imageWithColor(CD_Btn_MainColor, _size: CGSizeMake(kScreenWidth, backButton.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height)), forState: UIControlState.Normal)
        backButton.setBackgroundImage(Utility.imageWithColor(CD_Btn_MainColor_Clicked, _size: CGSizeMake(kScreenWidth, backButton.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height)), forState: UIControlState.Highlighted)
        
        return footerView
    }
    
    //MARK:--实现点击返回列表按钮
    func backToVC()
    {
        submitSuccessDelegate?.didSelectedBackToServiceList()
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
