//
//  HWServiewProductCell.swift
//  Partner-Swift
//
//  Created by hw500027 on 15/2/3.
//  Copyright (c) 2015年 luxiaobo. All rights reserved.
//
//  功能描述：服务首页-客户列表自定义cell
//
//  修改记录：
//      姓名         日期              修改内容
//    陆晓波      2015-02-12           文件创建
//

import UIKit

class HWServiewProductCell: HWBaseTableViewCell {
    
    var _imgView:UIImageView!
    var _nameLabel:UILabel!
    var _contentLabel:UILabel!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //图片
        _imgView = UIImageView(forAutoLayout: ())
        _imgView.layer.masksToBounds = true
        _imgView.layer.cornerRadius = 30
        self.contentView.addSubview(_imgView)
        
        _imgView.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: self.contentView)
        _imgView.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: self.contentView, withOffset: serviceCustomerCell_offset_15 * kRate)
        _imgView.autoSetDimension(ALDimension.Width, toSize: 60 * kRate)
        _imgView.autoSetDimension(ALDimension.Height, toSize: 60 * kRate)
        
        _imgView.image = Utility.getPlaceHolderImage(_imgView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize), imageName: "pic_wait_big")
        
        //服务产品
        _nameLabel = UILabel(forAutoLayout: ())
        _nameLabel.font = Define.font(TF_15)
        self.contentView.addSubview(_nameLabel)
        
        _nameLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: _imgView, withOffset: serviceCustomerCell_offset_20 * kRate)
        _nameLabel.autoSetDimension(ALDimension.Height, toSize: TF_15)
        _nameLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: self.contentView, withOffset: serviceCustomerCell_offset_15 * kRate)
        
        //介绍
        _contentLabel = UILabel(forAutoLayout: ())
        _contentLabel.font = Define.font(TF_13)
        _contentLabel.textColor = CD_Txt_Color_99
        self.contentView.addSubview(_contentLabel)
        
        _contentLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: _nameLabel)
        _contentLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: _nameLabel, withOffset: serviceCustomerCell_offset_15 * kRate)
        
        //右箭头
        var rightArrowImgV = UIImageView(forAutoLayout: ())
        rightArrowImgV.image = UIImage(named: "arrow_next")
        self.contentView.addSubview(rightArrowImgV)
        
        rightArrowImgV.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: self.contentView, withOffset: -serviceCustomerCell_offset_15 * kRate)
        rightArrowImgV.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: self.contentView)
    }
    
    
    func fillWithData(model:HWServiceProductModel)
    {
        if (model.productName == "房产过户")
        {
            _imgView.image = UIImage(named: "product2")
        }
        else if (model.productName == "房产更名")
        {
            _imgView.image = UIImage(named: "product1")
        }
        else
        {
            _imgView.image = UIImage(named: "product4")
        }
//        weak var weakImgView = _imgView
//         let url = NSURL(string:Utility.imageDownloadWithMongoDbKey(model.imageURL!))
//         _imgView.setImageWithURL(url, placeholderImage: Utility.getPlaceHolderImage(_imgView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize), imageName: "pic_wait_small")) { (image, error, imageCacheType) -> Void in
//            if (error != nil)
//            {
//                weakImgView?.image = Utility.getPlaceHolderImage(self._imgView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize), imageName: "pic_wait_small_no")
//            }
//            else
//            {
//                weakImgView?.image = image
//            }
//        }
    
        var chanceType:NSString = ""
        if (model.chanceType == "warrant")
        {
            chanceType = "[权证]"
        }
        else if (model.chanceType == "financial")
        {
            chanceType = "[金融]"
        }
        _nameLabel.text = "\(chanceType) \(model.productName!)"
        _contentLabel.text = model.productDescription
    }
    
    required init(coder aDecoder: NSCoder)
    {
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
