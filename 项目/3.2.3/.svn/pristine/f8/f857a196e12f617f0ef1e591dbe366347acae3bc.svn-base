//
//  HWCustomerDetailTableViewCell.swift
//  Partner-Swift
//
//  Created by gusheng on 15/2/25.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWCustomerDetailTableViewCell: UITableViewCell
{
    var followRecordContentLabel:UILabel = UILabel();
     var dateLabel:UILabel = UILabel()
     var circleImageV:UIImageView = UIImageView()
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

    }
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        var circleFrame:CGRect = CGRectMake(15, 5, 10, 10);
        circleImageV = createCustomerImageView(circleFrame, "");
        circleImageV.backgroundColor = CD_GrayColor;
        circleImageV.layer.cornerRadius = 5.0;
        circleImageV.layer.masksToBounds = true;
        self.addSubview(circleImageV);
        
        var dateLabelFrame:CGRect = CGRectMake(CGRectGetMaxX(circleImageV.frame)+2, circleImageV.frame.origin.y-2, 150, 15);
        dateLabel = createCustomeLabel(dateLabelFrame, CD_Txt_Color_99, "", TF_13);
        self.addSubview(dateLabel);
        
        var followRecordFrame:CGRect = CGRectMake(dateLabel.frame.origin.x,CGRectGetMaxY(dateLabel.frame)+10,kScreenWidth-15-dateLabel.frame.origin.x,20);
        followRecordContentLabel = createCustomeLabel(followRecordFrame, CD_Txt_Color_33, "", TF_13);
        followRecordContentLabel.lineBreakMode = NSLineBreakMode (rawValue: 1)!
       

        self.addSubview(followRecordContentLabel);
        
    }
    func didMakeModel(listModel:HWHouseListModel)
    {
        dateLabel.text = listModel.time
        followRecordContentLabel.text = listModel.content
         var size = Utility.calculateStringSize(listModel.content!, textFont:Define.font(13), constrainedSize: CGSizeMake(kScreenWidth-30, 1000))
         followRecordContentLabel.numberOfLines = 0
        followRecordContentLabel.frame = CGRectMake(dateLabel.frame.origin.x,CGRectGetMaxY(dateLabel.frame)+10,kScreenWidth-15-dateLabel.frame.origin.x, size.height+5)
    }
//    override func layoutSubviews()
//    {
//        super.layoutSubviews();
//        var textLableFrame = followRecordContentLabel.frame
//        followRecordContentLabel.frame = textLableFrame
//        
//        var fatucalSize:CGRect = returnLabelVerticalFactualSize(followRecordContentLabel, TF_13);
//        followRecordContentLabel.frame = fatucalSize;
//        
//      //  var size = followRecordContentLabel.text
//        var size = Utility .calculateStringSize(followRecordContentLabel.text!, textFont:Define.font(13), constrainedSize: CGSizeMake(1000, 300))
//        textLableFrame.size.height = size.height
//        followRecordContentLabel.frame = textLableFrame
//        //followRecordContentLabel.sizeToFit()
//        
//        
//    }

}
