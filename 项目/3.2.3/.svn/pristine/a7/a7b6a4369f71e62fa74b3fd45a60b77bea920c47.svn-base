//
//  HWSecEditPhotoTableViewCell.swift
//  Partner-Swift
//
//  Created by wuxiaohong on 15/4/13.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWSecEditPhotoTableViewCell: UITableViewCell {
    var appointImg: UIImageView! //预约人数图标
    var titleLab: UILabel!  //标题
    var detailLab: UILabel!//详情 末行
    var isDianji:Bool!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        titleLab = UILabel(frame: CGRectMake(15, 10, 100, 20))
        titleLab.font =  Define.font(TF_15)
        self.contentView .addSubview(titleLab)
        
        detailLab = UILabel(frame: CGRectMake(15, CGRectGetMaxY(titleLab.frame), 200, 20))
        detailLab.textColor = CD_Txt_Color_99
        detailLab.font =  Define.font(TF_13)
        self.contentView .addSubview(detailLab)
        appointImg = UIImageView()
        appointImg.image = UIImage(named: "choose_2_1")
        isDianji = true
        appointImg.frame = CGRectMake(kScreenWidth-15-15, 50-15/2, 15,15)
       // self.contentView.addSubview(appointImg)


        
    }
    class func getCellHeight() -> CGFloat
    {
        return 60
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
