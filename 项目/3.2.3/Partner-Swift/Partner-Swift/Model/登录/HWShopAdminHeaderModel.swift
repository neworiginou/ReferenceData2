//
//  HWShopAdminHeaderModel.swift
//  Partner-Swift
//
//  Created by hw500028 on 15/2/28.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import Foundation
/*
address = "<null>";
areaId = 157;
contactPhone = "<null>";
createTime = 1425543913000;
creater = "<null>";
creator = "<null>";
disabled = 0;
id = 54;
lat = "<null>";
lng = "<null>";
modifier = "<null>";
modifyTime = 1425543913000;
name = "\U4ee3\U7406\U9500\U552e\U90e8\U2014\U8fce\U6625\U5206\U90e8";
orgId = 9;
personNum = "<null>";
registerCode = "";
version = 0;
*/
class HWShopAdminHeaderModel: NSObject {
    var address = ""
    var areaId = ""
    var contactPhone = ""
    var createTime = ""
    var creater = ""
    var disabled = ""
    var id = ""
    var lat = ""
    var lng = ""
    var modifier = ""
    var modifyTime = ""
    var name = ""
    var orgId = ""
    var personNum = ""
    var version = ""
    var registerCode = ""
    var groupIsOpen = false
    init(dic:NSDictionary)
    {
        self.address = dic.stringObjectForKey("address")
        self.areaId = dic.stringObjectForKey("areaId")
        self.contactPhone = dic.stringObjectForKey("contactPhone")
        self.creater = dic.stringObjectForKey("creater")
        self.createTime = dic.stringObjectForKey("createTime")
        self.disabled = dic.stringObjectForKey("disabled")
        self.id = dic.stringObjectForKey("id")
        self.lat = dic.stringObjectForKey("lat")
        self.lng = dic.stringObjectForKey("lng")
        self.modifier = dic.stringObjectForKey("modifier")
        self.modifyTime = dic.stringObjectForKey("modifyTime")
        self.name = dic.stringObjectForKey("name")
        self.orgId = dic.stringObjectForKey("orgId")
        self.personNum = dic.stringObjectForKey("personNum")
        self.registerCode = dic.stringObjectForKey("registerCode")
        self.version = dic.stringObjectForKey("version")
    }
}
