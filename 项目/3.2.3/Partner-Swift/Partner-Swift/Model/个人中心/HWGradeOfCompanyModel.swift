//
//  HWGradeOfCompanyModel.swift
//  Partner-Swift
//
//  Created by WeiYuanlin on 15/3/4.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//
//  功能描述：我的排行榜-机构model
//
//  魏远林    2015-03-04    创建文件
//

import UIKit

class HWGradeOfCompanyModel: NSObject
{
    var name:String?//经纪人姓名
    var result:NSString?//经济人业绩
    
    init(dic:NSDictionary)
    {
        super.init()
        
        name = dic.stringObjectForKey("name")
        result = dic.stringObjectForKey("result")
    }
   
}
