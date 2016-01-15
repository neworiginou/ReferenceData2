//
//  UIColorExtension.swift
//  家教
//
//  Created by goofygao on 15/10/21.
//  Copyright © 2015年 goofyy. All rights reserved.
//

import UIKit

extension UIColor  {
    class func randColor(alpha:CGFloat) -> UIColor {
        let red = CGFloat(arc4random_uniform(255))/CGFloat(INT8_MAX)
        let green = CGFloat(arc4random_uniform(255))/CGFloat(INT8_MAX)
        let blue = CGFloat(arc4random_uniform(255))/CGFloat(INT8_MAX)
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
