//
//  HWSubordinateTopView.swift
//  Partner-Swift
//
//  Created by hw500029 on 15/2/16.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWSubordinateTopView: UIView
{
    var monthLabel:UILabel?
    var achievementLabel:UILabel?
    typealias selectCustomerBlock = () ->Void
    var selectMonth = selectCustomerBlock?()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = CD_BackGroundColor
        //monthLabel?.adjustsFontSizeToFitWidth
        
        //月份筛选条背景视图
        let topBackView = UIView.newAutoLayoutView()
        topBackView.backgroundColor = UIColor.clearColor()
        self.addSubview(topBackView)
        topBackView.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: self)
        topBackView.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        topBackView.autoSetDimension(ALDimension.Width, toSize: 102 - 7 )
        topBackView.autoSetDimension(ALDimension.Height, toSize: 45 * kScreenRate)
        var tapGas = UITapGestureRecognizer(target: self, action: "select")
        topBackView.addGestureRecognizer(tapGas)
        
        let iViewL = UIImageView.newAutoLayoutView()
        iViewL.backgroundColor = UIColor.clearColor()
        iViewL.image = UIImage(named:"schedule2")
        topBackView.addSubview(iViewL)
        iViewL.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: topBackView)
        iViewL.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        iViewL.autoSetDimension(ALDimension.Width, toSize: 40 / 2)
        iViewL.autoSetDimension(ALDimension.Height, toSize: 37 / 2)
        
        let iViewR = UIImageView.newAutoLayoutView()
        iViewR.backgroundColor = UIColor.clearColor()
        iViewR.image = UIImage(named:"filter_down4")
        topBackView.addSubview(iViewR)
        iViewR.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: topBackView)
        iViewR.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        iViewR.autoSetDimension(ALDimension.Width, toSize: 14 / 2)
        iViewR.autoSetDimension(ALDimension.Height, toSize: 7 / 2)
        
        monthLabel = UILabel.newAutoLayoutView()
        monthLabel?.backgroundColor = UIColor.clearColor()
        monthLabel?.font = Define.font(TF_13)
        monthLabel?.textColor = CD_Txt_Color_00
        topBackView.addSubview(monthLabel!)
        monthLabel?.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: iViewL, withOffset: 10)
        monthLabel?.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        monthLabel?.autoSetDimension(ALDimension.Height, toSize: 30)
        
        //业绩部分背景视图
        let achieveBackView = UIView.newAutoLayoutView()
        achieveBackView.backgroundColor = UIColor.whiteColor()
        self.addSubview(achieveBackView!)
        achieveBackView.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: topBackView)
        achieveBackView.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView:self)
        achieveBackView.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView:self)
        achieveBackView.autoSetDimension(ALDimension.Height, toSize: 125 * kScreenRate)
        achieveBackView.autoSetDimension(ALDimension.Width, toSize: kScreenWidth)
        achieveBackView.drawTopLine()
        achieveBackView.drawBottomLine()
        
        let achInfoLabel = UILabel.newAutoLayoutView()
        achInfoLabel.backgroundColor = UIColor.clearColor()
        achInfoLabel.font = Define.font(TF_15)
        achInfoLabel.textColor = CD_Txt_Color_00
        achInfoLabel.text = "业绩"
        achieveBackView.addSubview(achInfoLabel)
        achInfoLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: achieveBackView, withOffset: 15 * kScreenRate)
        achInfoLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: achieveBackView, withOffset: 20 * kScreenRate)

        achievementLabel = UILabel.newAutoLayoutView()
        achievementLabel?.backgroundColor = UIColor.clearColor()
        achievementLabel?.font = Define.font(TF_30)
        achievementLabel?.textColor = CD_MainColor
        self.setYuanLabel("")
        achieveBackView.addSubview(achievementLabel!)
        achievementLabel?.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        achievementLabel?.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: achInfoLabel, withOffset: 25 * kScreenRate)
        achievementLabel?.autoSetDimension(ALDimension.Height, toSize: 30)
        
        let titles = ["报备","到访","下定","成交"]
        var eachWidth:CGFloat = kScreenWidth / 4
        for var i:CGFloat = 0; i < 4; i++
        {
            let singleView = UIView.newAutoLayoutView()
            singleView.backgroundColor = CD_GrayColor
            self.addSubview(singleView)
            singleView.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: self, withOffset:(i * eachWidth))
            singleView.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: achieveBackView)
            singleView.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Bottom, ofView: self)
            singleView.autoSetDimension(ALDimension.Width, toSize: eachWidth)
            
            let titleLabel = UILabel.newAutoLayoutView()
            titleLabel.backgroundColor = UIColor.clearColor()
            titleLabel.font = Define.font(TF_13)
            titleLabel.textColor = CD_Txt_Color_00
            titleLabel.text = titles[Int(i)]
            singleView.addSubview(titleLabel)
            titleLabel.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
            titleLabel.autoSetDimension(ALDimension.Height, toSize: 13 * kScreenRate)
            titleLabel.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Bottom, ofView: singleView, withOffset: -10 * kScreenRate)
            
            let numLabel =  UILabel.newAutoLayoutView()
            numLabel.backgroundColor = UIColor.clearColor()
            numLabel.font = Define.font(TF_15)
            numLabel.textColor = CD_MainColor
            //numLabel.text = "0组"
            numLabel.tag = 100 + Int(i)
            singleView.addSubview(numLabel)
            numLabel.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
            numLabel.autoSetDimension(ALDimension.Height, toSize: 15 * kScreenRate)
            numLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: singleView, withOffset: 10 * kScreenRate)
            
            //画分割线
            if(Int(i) < 3)
            {
                let line = UILabel.newAutoLayoutView()
                line.backgroundColor = CD_LineColor
                singleView.addSubview(line)
                line.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0, 0, 0, 0), excludingEdge: ALEdge.Left)
                line.autoSetDimension(ALDimension.Width, toSize: 0.5)
            }
        }
    
        self.fetchFourData(["0组","0组","0组","0组"])
        
        self.drawBottomLine()
    }

    func select()
    {
        println("点击时间选择器")
        selectMonth!()
    }
    
    //填充底部四个数据
    func fetchFourData(arr:NSArray)
    {
        for var i = 0; i<4; i++
        {
            var label = self.viewWithTag(i + 100) as UILabel
            let text = arr.pObjectAtIndex(i) as? NSString
            let length = text?.length
            var attri = NSMutableAttributedString(string: text!)
            attri.addAttribute(NSFontAttributeName, value: Define.font(TF_13), range: NSMakeRange(length! - 1, 1))
            label.attributedText = attri
        }
    }
    
    func setYuanLabel(str:NSString)
    {
        var achievement:NSString = ""
        if str.isEqualToString("")
        {
            achievement = "￥0.00"
        }
        else
        {
            var numberFormatter = NSNumberFormatter()
            numberFormatter.positiveFormat = "0.00"
            var str:NSString = numberFormatter.stringFromNumber(NSNumber(double:str.doubleValue))!
            achievement = "￥\(str)"
        }
        var attriStr = NSMutableAttributedString(string: achievement)
        attriStr.addAttribute(NSFontAttributeName, value: Define.font(TF_19), range: NSMakeRange(0, 1))
        self.achievementLabel?.attributedText = attriStr

    }
    
    
   
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
