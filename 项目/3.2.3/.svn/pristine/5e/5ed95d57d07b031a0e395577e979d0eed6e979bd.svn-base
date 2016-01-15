//
//  HWPrevilidgeTableViewCell.swift
//  Partner-Swift
//
//  Created by gusheng on 15/5/24.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWPrevilidgeTableViewCell: UITableViewCell
{
    var floorNameLabel:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        var lineImageV:UIImageView = UIImageView(frame: CGRectMake(0, 0, kScreenWidth, 0.5))
        lineImageV.backgroundColor = CD_LineColor
        self.contentView.addSubview(lineImageV);

        floorNameLabel = UILabel(frame: CGRectMake(15, 12.5, kScreenWidth-30, 15));
        floorNameLabel.font = UIFont.systemFontOfSize(TF_13);
        floorNameLabel.text = "凤凰新城的看打开贷款的贷款贷款|1000万|2014-7-28至2014-8-28";
        self.contentView.addSubview(floorNameLabel);
    }
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

}
