//
//  HWNewHouseList.swift
//  Partner-Swift
//
//  Created by zhangxun on 15/3/24.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import Foundation
import CoreData

@objc(HWNewHouseList)class HWNewHouseList: NSManagedObject {

    @NSManaged var houseId: String
    @NSManaged var houseName: String
    @NSManaged var houseAddress: String
    @NSManaged var brokerNum: String
    @NSManaged var clientNum: String
    @NSManaged var houseAvgPrice: String
    @NSManaged var commission: String
    @NSManaged var shareUrl: String
    @NSManaged var housePic: String
    @NSManaged var sortSign: NSNumber

}
