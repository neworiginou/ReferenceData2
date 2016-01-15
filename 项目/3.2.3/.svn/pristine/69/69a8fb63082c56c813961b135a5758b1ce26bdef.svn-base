//
//  HWBrokerCell.swift
//  Partner-Swift
//
//  Created by hw500028 on 15/3/2.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWBrokerCell: HWBaseTableViewCell {

    var nameLabel:UILabel?
    var arrowImagV:UIImageView?
    var telLabel:UILabel?
   override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    arrowImagV = UIImageView.newAutoLayoutView()
    self.contentView.addSubview(arrowImagV!)
    arrowImagV?.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: 15)
    arrowImagV?.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
    arrowImagV?.autoSetDimensionsToSize(CGSize(width: 8, height: 14))
    arrowImagV?.image = UIImage(named: "arrow_next")
    nameLabel = UILabel.newAutoLayoutView()
    self.contentView.addSubview(nameLabel!)
    nameLabel?.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 15, bottom: 0, right: kScreenWidth - 90))
    
    nameLabel?.font = Define.font(TF_15)
    nameLabel?.backgroundColor = UIColor.clearColor()
    //
    telLabel = UILabel.newAutoLayoutView()
    self.contentView.addSubview(telLabel!)
    telLabel?.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Left, ofView: arrowImagV, withOffset: -10)
    telLabel?.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: nameLabel, withOffset: 15)
    telLabel?.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: 0)
    telLabel?.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 0)
    telLabel?.font = Define.font(TF_15)
    telLabel?.backgroundColor = UIColor.clearColor()
    }

   required init(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
    
    
}
