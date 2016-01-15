//
//  HWShopAdminHeaderView.swift
//  Partner-Swift
//
//  Created by hw500028 on 15/2/28.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

protocol HWShopAdminHeaderViewDelegate:NSObjectProtocol
{
    func  addBrokerBtnClick(hwSection:Int) -> Void
    func  headerControlClick(hwSection:Int) -> Void
    
}

class HWShopAdminHeaderView: UITableViewHeaderFooterView {
    var shopNameLabel:UILabel?
    var shopInvideLabel:UILabel?
    var brokerNumLabel:UILabel?
    var arrowImageView:UIImageView?
    var open = false
    var delegate:HWShopAdminHeaderViewDelegate?
    var shopAdminModel:HWShopAdminHeaderModel?
    {
            didSet
            {
                shopInvideLabel?.text = "门店邀请码: \(shopAdminModel!.registerCode)"
                brokerNumLabel?.text = "\(shopAdminModel!.personNum)"
                shopNameLabel?.text = "\(shopAdminModel!.name)"
        }
    }
    
    //创建头部视图
    class func headerViewWithTableView(tableView:UITableView,hwSection:Int) ->HWShopAdminHeaderView
    {
        
        let identify = "headerView\(hwSection)"

        var headerView:HWShopAdminHeaderView? = tableView.dequeueReusableHeaderFooterViewWithIdentifier(identify) as? HWShopAdminHeaderView
        if headerView == nil
        {
            headerView = HWShopAdminHeaderView(reuseIdentifier: identify, hwSection: hwSection)
    
        }
        return headerView!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(reuseIdentifier: String?,hwSection:Int) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.whiteColor()
        let nameBackgroudView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 44))
        self.contentView.addSubview(nameBackgroudView)
        nameBackgroudView.backgroundColor = UIColor.clearColor()
        //店铺名
        shopNameLabel = UILabel(frame: CGRect(x: 15, y: 0, width: kScreenWidth - 95, height: 44))
        shopNameLabel?.text = "宝山店"
        shopNameLabel?.font = Define.font(TF_15)
        nameBackgroudView.addSubview(shopNameLabel!)
        
        //添加经纪人
        let addBrokerControl = UIControl(frame: CGRect(x: kScreenWidth - 95, y: 0, width: 80, height: 44))
        addBrokerControl.backgroundColor = UIColor.clearColor()
        nameBackgroudView.addSubview(addBrokerControl)
        addBrokerControl.addTarget(self, action: "addBrokerAction:", forControlEvents: UIControlEvents.TouchUpInside)
        addBrokerControl.tag = 1000 + hwSection
        let hwImageView = UIImageView.newAutoLayoutView()
        addBrokerControl.addSubview(hwImageView)
        hwImageView.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 0)
        hwImageView.autoSetDimensionsToSize(CGSize(width: 30, height: 30))
        hwImageView.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        hwImageView.image = UIImage(named: "add_icon2")
    
        let hwlabel = UILabel.newAutoLayoutView()
        addBrokerControl.addSubview(hwlabel)
        hwlabel.text = "经纪人"
        hwlabel.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: 0)
        hwlabel.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        hwlabel.textColor = UIColor.orangeColor()
        hwlabel.font = Define.font(TF_15)
        hwlabel.backgroundColor = UIColor.clearColor()
        //
        let invideCodeControl = UIControl(frame: CGRect(x: 0, y: CGRectGetMaxY(nameBackgroudView.frame), width: kScreenWidth, height: 44))
        invideCodeControl.addTarget(self, action: "invideCodeAction:", forControlEvents: UIControlEvents.TouchUpInside)
        invideCodeControl.tag = 100 + hwSection
        self.contentView.addSubview(invideCodeControl)
        invideCodeControl.drawTopLine()
        //箭头
        arrowImageView = UIImageView.newAutoLayoutView()
        invideCodeControl.addSubview(arrowImageView!)
        arrowImageView?.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: 15)
        arrowImageView?.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        arrowImageView?.autoSetDimensionsToSize(CGSize(width: 14, height: 14))
        arrowImageView?.contentMode = UIViewContentMode.Center
        arrowImageView?.image = UIImage(named: "arrow_up")
        arrowImageView?.backgroundColor = UIColor.clearColor()
        //经纪人数量
        brokerNumLabel = UILabel.newAutoLayoutView()
        invideCodeControl.addSubview(brokerNumLabel!)
        brokerNumLabel?.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Left, ofView: arrowImageView!, withOffset: -5)
        brokerNumLabel?.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        brokerNumLabel?.backgroundColor = UIColor.clearColor()
        //邀请码
        shopInvideLabel = UILabel.newAutoLayoutView()
        invideCodeControl.addSubview(shopInvideLabel!)
        shopInvideLabel?.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 15)
        shopInvideLabel?.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Left, ofView: brokerNumLabel)
        shopInvideLabel?.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        shopInvideLabel?.font = Define.font(TF_15)
        shopInvideLabel?.textColor = CD_Txt_Color_99
        UIView.autoSetPriority(100, forConstraints: { () -> Void in
           self.shopInvideLabel?.autoSetContentHuggingPriorityForAxis(ALAxis.Horizontal)
            return
        })
    
    self.contentView.drawBottomLine()
    }
    
    //MARK:---actions
    func invideCodeAction(sender:UIControl) ->Void
    {
        let hwSection = sender.tag - 100
        shopAdminModel!.groupIsOpen = !shopAdminModel!.groupIsOpen
        if (delegate != nil && delegate?.respondsToSelector("headerControlClick:") != false)
        {
            delegate?.headerControlClick(hwSection)
        }

    }
    
    override func didMoveToSuperview() {
        if shopAdminModel!.groupIsOpen
        {
            arrowImageView!.image = UIImage(named: "arrow_up")
        }
        else
        {
            arrowImageView!.image = UIImage(named: "arrow_down")
            
        }

    }
    
    func addBrokerAction(sender:UIControl) -> Void
    {
        MobClick.event("Addbroker_click")//埋点
        let hwSection = sender.tag - 1000
        if (delegate != nil && delegate?.respondsToSelector("addBrokerBtnClick:") != false)
        {
            delegate?.addBrokerBtnClick(hwSection)
        }

    }
   required init(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
    
}
