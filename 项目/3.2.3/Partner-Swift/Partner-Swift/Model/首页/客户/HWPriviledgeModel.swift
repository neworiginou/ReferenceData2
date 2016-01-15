//
//  HWPriviledgeModel.swift
//  Partner-Swift
//
//  Created by gusheng on 15/5/26.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWPriviledgeModel: NSObject
{
    /*
    couponMoney = 5000;
    id = 11451906468;
    title = "\U5929\U5c45\U73b2\U73d1\U6e7e";
    validityTime = "2015.5.22-2015.5.31";
    */
    var couponMoney:String! = ""//是否过期
    var id:String! = ""
    var title:NSString! = ""
    var validityTime:String! = ""
    
    init(dic:NSDictionary)
    {
        couponMoney = dic.stringObjectForKey("couponMoney")
        id = dic.stringObjectForKey("id")
        title = dic.stringObjectForKey("title")
        if(title.length > 7)
        {
            title = title.substringToIndex(7) + "..."
        }
        validityTime = dic.stringObjectForKey("validityTime")
    }
}
