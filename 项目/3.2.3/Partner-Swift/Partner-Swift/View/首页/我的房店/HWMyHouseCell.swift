//
//  HWMyHouseCell.swift
//  Partner-Swift
//
//  Created by hw500027 on 15/3/3.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：我的房店-我的房源列表cell
//
//  修改记录：
//      姓名         日期              修改内容
//    陆晓波      2015-03-03           文件创建

import UIKit

protocol HWMyHouseCellDelegate:NSObjectProtocol
{
    func didClickRefreshBtn(model:HWMyHouseModel)
}

class HWMyHouseCell: HWBaseTableViewCell
{
    weak var myHouseCellDelegate:HWMyHouseCellDelegate?
    
    var _houseNameLabel:UILabel!
    var _addressNameLabel:UILabel!
    var _collectNumLabel:UILabel!
    var _statusLabel:UILabel!
    var _refreshBtn:UIButton!
    var _signLableView:HWStreamLabelView!
    var _signLabel:UILabel!
    var _model:HWMyHouseModel!
    var refreshImgView:UIImageView!
    var isClickBtn:Bool?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //小区名+几栋几室
        _houseNameLabel = UILabel(forAutoLayout: ())
        _houseNameLabel.font = Define.font(TF_15)
        self.contentView.addSubview(_houseNameLabel)
        
        _houseNameLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: self.contentView, withOffset: 12)
        _houseNameLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: self.contentView, withOffset: serviceCustomerCell_offset_15)
        _houseNameLabel.autoSetDimension(ALDimension.Height, toSize: TF_15)
        
        //区域加板块
        _addressNameLabel = UILabel(forAutoLayout: ())
        _addressNameLabel.font = Define.font(TF_13)
        _addressNameLabel.textColor = CD_Txt_Color_99
        self.contentView.addSubview(_addressNameLabel)
        
        _addressNameLabel.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Bottom, ofView: _houseNameLabel)
        _addressNameLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: _houseNameLabel, withOffset: serviceCustomerCell_offset_10)
        _addressNameLabel.autoSetDimension(ALDimension.Height, toSize: TF_15)
        
        //关注经纪人数
        _collectNumLabel = UILabel(forAutoLayout: ())
        _collectNumLabel.font = Define.font(TF_13)
        _collectNumLabel.textColor = CD_Txt_Color_99
        self.contentView.addSubview(_collectNumLabel)
        
        _collectNumLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: _houseNameLabel)
        _collectNumLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: _houseNameLabel, withOffset: serviceCustomerCell_offset_10)
        _collectNumLabel.autoSetDimension(ALDimension.Height, toSize: TF_13)
        
        //刷新按钮
        _refreshBtn = UIButton(forAutoLayout: ())
        //_refreshBtn.setImage(UIImage(named: "refresh"), forState: UIControlState.Normal)
        //_refreshBtn.backgroundColor = UIColor.redColor()
        _refreshBtn.hidden = false
        isClickBtn = false
        self.contentView.addSubview(_refreshBtn)
        _refreshBtn.addTarget(self, action: "didSelectedRefreshBtn", forControlEvents: UIControlEvents.TouchUpInside)
        
        //_refreshBtn.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: self.contentView, withOffset: -serviceCustomerCell_offset_15)
        _refreshBtn.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: self.contentView)
        _refreshBtn.autoSetDimension(ALDimension.Width, toSize: 60 * kScreenRate)
        _refreshBtn.autoSetDimension(ALDimension.Height, toSize: 60 * kScreenRate)
        _refreshBtn.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: self.contentView)
        
        refreshImgView = UIImageView(forAutoLayout: ())
        refreshImgView.image = UIImage(named: "refresh")
        _refreshBtn.addSubview(refreshImgView)
        
        refreshImgView.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: _refreshBtn, withOffset: -serviceCustomerCell_offset_15)
        refreshImgView.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: _refreshBtn)
        
        
        //状态
        _statusLabel = UILabel(forAutoLayout: ())
        _statusLabel.font = Define.font(TF_13)
        _statusLabel.textColor = CD_Txt_Color_99
        _statusLabel.hidden = true
        _statusLabel.text = "已下架"
        self.contentView.addSubview(_statusLabel)
        
        _statusLabel.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: self.contentView, withOffset: -serviceCustomerCell_offset_15)
        _statusLabel.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: self.contentView)
    }
    
    func fillWithData(model:HWMyHouseModel)
    {
        _model = model
        _houseNameLabel.text = model.houseName
        _addressNameLabel.text = model.addressName == "[]" ? "" : model.addressName
        _collectNumLabel.text = "经纪人预约：\(model.collectNum!)"
        
        //状态为已下架，显示状态信息
        if (model.status == "putdown")
        {
            _refreshBtn.hidden = true
            _statusLabel.hidden = false
            self.contentView.backgroundColor = CD_GrayColor
        }
        else if(model.status == "deal")
        {
            _refreshBtn.hidden = true
            _statusLabel.hidden = false
             _statusLabel.text = "已成交";
            self.contentView.backgroundColor = CD_GrayColor
        }
        else if(model.status == "audit")
        {
            _refreshBtn.hidden = true
            _statusLabel.hidden = false
            _statusLabel.text = "审核中";
            _statusLabel.textColor = CD_GreenColor
        }
        else
        {
            _refreshBtn.hidden = false
            _statusLabel.hidden = true
            self.contentView.backgroundColor = UIColor.whiteColor()
        }
        
        var strSign:NSString = model.sign!
        
        var arrSign:NSMutableArray? = NSMutableArray()
        if (model.sign == "<null>" || model.sign?.length == 0 || model.sign == "")
        {
            arrSign = Optional.None
        }
        else
        {
            arrSign = NSMutableArray(array: strSign.componentsSeparatedByString(","))
        }

        if (_signLableView != nil)
        {
            _signLableView.removeFromSuperview()
        }
        //var sizeHeight:CGFloat = _collectNumLabel.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height + 45.0
        _signLableView = HWStreamLabelView(item: arrSign, constrainedFrame: CGRectMake(15, 60 ,kScreenWidth-60, 1000), constrainedItemSize: CGSizeMake(1000, 18));
        _signLableView.itemBorderColor = CD_MainColor.CGColor;
        _signLableView.itemBorderWidth = 1.0;
        _signLableView.itemCornerRadius = 3.0;
        _signLableView.itemTitleColor = CD_MainColor;
        _signLableView.itemFont = Define.font(TF_12)
        self.contentView.addSubview(_signLableView)
        
    }

    func didSelectedRefreshBtn()
    {
        println("housecell 刷新")
        //旋转刷新按钮
        if (isClickBtn == false)
        {
            UIView.animateWithDuration(0.3, animations:
            { () -> Void in
                self.refreshImgView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
                self.myHouseCellDelegate?.didClickRefreshBtn(self._model)
            }, completion:
            { (success) -> Void in
                self.isClickBtn = true
            })
        }
        else if (isClickBtn == true)
        {
            UIView.animateWithDuration(0.3, animations:
            { () -> Void in
                self.refreshImgView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI) * 2)
                self.myHouseCellDelegate?.didClickRefreshBtn(self._model)
            }, completion:
            { (success) -> Void in
                self.isClickBtn = false
            })
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
