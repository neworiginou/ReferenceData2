//
//  HWInputCell.swift
//  Partner-Swift
//
//  Created by caijingpeng.haowu on 15/2/16.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：带有 输入框textview的 cell
//
//  修改记录：
//      姓名         日期               修改内容
//     蔡景鹏     2015-02-11           创建文件
//

import UIKit

let inputCell_MarginLeft = 10 * kRate
let inputCell_MarginTop = 3 * kRate
let inputCell_Height = 140 * kRate

class HWInputCell: HWBaseTableViewCell {
    
    var textView: UITextView!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        textView = UITextView(frame: CGRectMake(inputCell_MarginLeft, inputCell_MarginTop, kScreenWidth - 2 * inputCell_MarginLeft, inputCell_Height - 2 * inputCell_MarginTop))
        textView.font = Define.font(TF_Text_15)
        textView.textColor = CD_Txt_Color_66
        
        self.contentView.addSubview(textView)
        
    }
    
    class func getIdentify() -> String
    {
        return "HWInputCell"
    }
    
    class func getCellHeight() -> CGFloat
    {
        return inputCell_Height
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
