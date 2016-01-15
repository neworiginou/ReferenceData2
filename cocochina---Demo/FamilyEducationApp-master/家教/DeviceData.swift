//
//  DeviceData.swift
//  家教
//
//  Created by goofygao on 15/10/19.
//  Copyright © 2015年 goofyy. All rights reserved.
//

import UIKit
/**
 *  建立系统数据单例模式
 */
struct DeviceData {
    static let height = UIScreen.mainScreen().bounds.height
    static let width  = UIScreen.mainScreen().bounds.width
    static let bound  = UIScreen.mainScreen().bounds
}