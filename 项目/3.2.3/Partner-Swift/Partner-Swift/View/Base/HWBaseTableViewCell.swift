//
//  HWBaseTableViewCell.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/16.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：定义cell基类  定义cell 选中后的颜色
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-02-16           创建文件
//

import UIKit

class HWBaseTableViewCell: UITableViewCell {
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectedBackgroundView = UIView()
        self.selectedBackgroundView.backgroundColor = CD_GrayColor
        self.contentView.backgroundColor = UIColor.whiteColor()
        self.backgroundColor = UIColor.whiteColor()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
