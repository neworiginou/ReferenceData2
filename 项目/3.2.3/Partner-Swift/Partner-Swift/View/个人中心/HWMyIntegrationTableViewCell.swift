//
//  HWMyIntegrationTableViewCell.swift
//  Partner-Swift
//
//  Created by WeiYuanlin on 15/2/27.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWMyIntegrationTableViewCell: HWBaseTableViewCell
{
    let cellHeight:CGFloat = 45.0
    var integrationLabel:UILabel!
    var IntegrationDirectStr:String!
    var descriptionLabel:UILabel!
    var dateLabel:UILabel!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        integrationLabel = UILabel(frame: CGRectMake(15.0  , (cellHeight - 15 * 2  ) / 2.0, 40  , 15  ))
        integrationLabel.font = Define.font(TF_14)
        integrationLabel.textColor = CD_MainColor
        integrationLabel.backgroundColor = UIColor.clearColor()
        self.contentView.addSubview(integrationLabel)
        
        descriptionLabel = UILabel(frame: CGRectMake(67  , (cellHeight - 15 * 2  ) / 2.0, 150  , 15  ))
        descriptionLabel.font = Define.font(TF_14)
        descriptionLabel.textColor = CD_Txt_Color_00
        descriptionLabel.backgroundColor = UIColor.clearColor()
        self.contentView.addSubview(descriptionLabel)
        
        dateLabel = UILabel(frame: CGRectMake(kScreenWidth - 90  , (cellHeight - 15 * 2  ) / 2.0, 68  , 15  ))
        dateLabel.font = Define.font(TF_14)
        dateLabel.textColor = CD_Txt_Color_99
        dateLabel.backgroundColor = UIColor.clearColor()
        self.contentView.addSubview(dateLabel)
        
    }

    //MARK: 重写坐标
    func rewriteViewFrame(integralModel:HWIntegrationListModel)
    {
        var integrationStr = integralModel.integral
        self.dateLabel.text = Utility.getTimeFormattWithTimeStamp(integralModel.integralTime)
        self.IntegrationDirectStr = integralModel.direct
        if self.IntegrationDirectStr == "in"
        {
            self.integrationLabel.text = "+\(integrationStr)"
            self.integrationLabel.textColor = CD_MainColor
        }
        else if self.IntegrationDirectStr == "out"
        {
            self.integrationLabel.text = "-\(integrationStr)"
            self.integrationLabel.textColor = CD_GreenColor
        }
        self.integrationLabel.sizeToFit()
        self.integrationLabel.frame = CGRectMake(15  , (cellHeight - self.integrationLabel.frame.size.height) / 2, self.integrationLabel.frame.size.width, self.integrationLabel.frame.size.height)
        
        self.descriptionLabel.text = "\(integralModel.type)"
        self.descriptionLabel.sizeToFit()
        self.descriptionLabel.frame = CGRectMake(CGRectGetMaxX(integrationLabel.frame) + 10, (cellHeight -  self.descriptionLabel.frame.size.height) / 2, self.descriptionLabel.frame.size.width, self.descriptionLabel.frame.size.height)
        
        self.dateLabel.sizeToFit()
        self.dateLabel.frame = CGRectMake(kScreenWidth - dateLabel.frame.size.width - 15, (cellHeight - dateLabel.frame.size.height) / 2, dateLabel.frame.size.width, dateLabel.frame.size.height)

    }
    
    class func setCellHeight()->CGFloat
    {
        return 45.0  
    }
    
    required init(coder aDecoder: NSCoder)
    {
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
