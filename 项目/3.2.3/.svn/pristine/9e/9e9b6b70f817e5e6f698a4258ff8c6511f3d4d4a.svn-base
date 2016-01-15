//
//  HWChartsHeadView.swift
//  Partner-Swift
//
//  Created by hw500029 on 15/2/15.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit



class HWChartsHeadView: UIView {
var titleLabel:UILabel?//几月业绩
var achievementLabel:UILabel?//当月总业绩
var percentageLabel:UILabel?//百分比
var listTitleLabel:UILabel?
    
var topL:UILabel?
var bottomL:UILabel?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = CD_BackGroundColor
        
        titleLabel = UILabel.newAutoLayoutView()
        titleLabel?.backgroundColor = UIColor.clearColor()
        titleLabel?.font = Define.font(TF_13)
        titleLabel?.textColor = CD_Txt_Color_99
        self.addSubview(titleLabel!)
        //titleLabel?.text = "我的1月业绩"
        titleLabel?.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: self, withOffset: 15 * kRate)
        titleLabel?.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: self, withOffset: 25 * kRate)
        //titleLabel?.autoSetDimension(ALDimension.Width, toSize: 80 * kScreenRate)
        titleLabel?.autoSetDimension(ALDimension.Height, toSize: 20 * kScreenRate)
        
        achievementLabel = UILabel.newAutoLayoutView()
        achievementLabel?.backgroundColor = UIColor.clearColor()
        achievementLabel?.textColor = CD_MainColor
        //achievementLabel?.text = "￥1,199,900,00"
        achievementLabel?.font = Define.font(TF_30)
        self.addSubview(achievementLabel!)
        achievementLabel?.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: self, withOffset: 15 * kRate)
        achievementLabel?.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: titleLabel, withOffset: 18 * kScreenRate)
        achievementLabel?.autoSetDimension(ALDimension.Height, toSize: 30 * kScreenRate)
        achievementLabel?.autoSetDimension(ALDimension.Width, toSize: 230 * kScreenRate)
        
        var diameterB = self.bounds.size.height - (26 + 30) * kScreenRate + CGFloat(kScreenWidth<350 ? 10:0)
        let backCircle = UIImageView.newAutoLayoutView()
        backCircle.image = UIImage(named: "performance_bg1")
        self.addSubview(backCircle)
        backCircle.autoSetDimension(ALDimension.Height, toSize: diameterB)
        backCircle.autoSetDimension(ALDimension.Width, toSize: diameterB)
        backCircle.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: self, withOffset:13 * kScreenRate - CGFloat(kScreenWidth<350 ? 5:0))
        backCircle.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: self, withOffset: -15 * kRate)

        percentageLabel = UILabel.newAutoLayoutView()
        percentageLabel?.backgroundColor = UIColor.clearColor()
        percentageLabel?.font = Define.font(TF_22)
        percentageLabel?.text = "0%"
        percentageLabel?.textAlignment = NSTextAlignment.Center
        percentageLabel?.textColor = CD_MainColor
        backCircle.addSubview(percentageLabel!)
        percentageLabel?.autoCenterInSuperview()
        percentageLabel?.autoSetDimension(ALDimension.Height, toSize: 25)
        percentageLabel?.autoSetDimension(ALDimension.Width, toSize: 80)
        
        topL = UILabel.newAutoLayoutView()
        topL?.backgroundColor = UIColor.clearColor()
        topL?.font = Define.font(TF_13)
        topL?.textAlignment = NSTextAlignment.Center
        topL?.textColor = CD_Txt_Color_99
        topL?.text = "超越"
        backCircle.addSubview(topL!)
        topL?.autoSetDimension(ALDimension.Width, toSize: 60)
        topL?.autoSetDimension(ALDimension.Height, toSize: 13)
        topL?.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        topL?.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: backCircle, withOffset: 15 * kRate)
        
        bottomL = UILabel.newAutoLayoutView()
        bottomL?.backgroundColor = UIColor.clearColor()
        bottomL?.font = Define.font(TF_13)
        bottomL?.textAlignment = NSTextAlignment.Center
        bottomL?.textColor = CD_Txt_Color_99
        bottomL?.numberOfLines = 0
       // bottomL?.text = "上海市经纪公司"
        backCircle.addSubview(bottomL!)
//        621 375
        if iPhone6plus
        {
            bottomL?.autoSetDimension(ALDimension.Width, toSize:90)
            bottomL?.autoSetDimension(ALDimension.Height, toSize: 13 * 2 + 5)
            bottomL?.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
            bottomL?.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: percentageLabel, withOffset: 0)
        }
        else if iPhone6
        {
            bottomL?.autoSetDimension(ALDimension.Width, toSize:75)
            bottomL?.autoSetDimension(ALDimension.Height, toSize: 13 * 2 + 5)
            bottomL?.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
            bottomL?.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: percentageLabel, withOffset: 0)
        }
        else
        {
            bottomL?.autoSetDimension(ALDimension.Width, toSize:70 )
            bottomL?.autoSetDimension(ALDimension.Height, toSize: 13 * 2 + 5)
            bottomL?.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
            bottomL?.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: percentageLabel, withOffset: -5)
        }
        //iPhone5
        
        let listTopView: UIView! = UIView.newAutoLayoutView()
        listTopView.backgroundColor = UIColor.whiteColor()
        self.addSubview(listTopView!)
        listTopView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0, 0, 0, 0), excludingEdge: ALEdge.Top)
        listTopView.autoSetDimension(ALDimension.Height, toSize: 30 * kScreenRate)
        listTopView.autoSetDimension(ALDimension.Width, toSize: kScreenWidth)
        
        listTopView.drawBottomLine()
        //listTopView.drawTopLine()
        
        listTitleLabel = UILabel.newAutoLayoutView()
        listTitleLabel?.font = Define.font(TF_13)
        listTitleLabel?.backgroundColor = UIColor.clearColor()
        listTitleLabel?.textColor = CD_Txt_Color_99
        listTopView.addSubview(listTitleLabel!)
        listTitleLabel?.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0, 15 * kScreenRate, 0, 0))
        
        let lineT = UIView.newAutoLayoutView()
        lineT.backgroundColor = CD_LineColor
        listTopView?.addSubview(lineT!)
        lineT.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0, 0, 0, 0), excludingEdge: ALEdge.Bottom)
        lineT.autoSetDimension(ALDimension.Height, toSize: 0.5)
        
//        let lineB = UIView.newAutoLayoutView()
//        lineB.backgroundColor = CD_LineColor
//        listTopView?.addSubview(lineB!)
//        lineB.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(0, 0, 0, 0), excludingEdge: ALEdge.Bottom)
//        
//        lineB.autoSetDimension(ALDimension.Height, toSize: 0.5)
        
    }
    
  
    func setYuanAttibuteString(str:String, font:CGFloat) -> NSMutableAttributedString
    {
        var attriStr = NSMutableAttributedString(string: str)
        attriStr.addAttribute(NSFontAttributeName, value: Define.font(font), range: NSMakeRange(0, 1))
        return attriStr
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
