//
//  HWIntegrationListModel
//  Partner-Swift
//
//  Created by WeiYuanlin on 15/3/5.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWIntegrationListModel: NSObject
{
    var integral:String!
    var direct:String!
    var type:String!
    var integralTime:String!
    
    init(dic:NSDictionary)
    {
        integral = dic.stringObjectForKey("integral")
        direct = dic.stringObjectForKey("direct")
        type = dic.stringObjectForKey("type")
        integralTime = dic.stringObjectForKey("integralTime")
    }
}
