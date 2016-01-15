//
//  CustomTextField.swift
//  家教
//
//  Created by goofygao on 15/11/22.
//  Copyright © 2015年 goofyy. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func drawPlaceholderInRect(rect: CGRect) {
        super.drawPlaceholderInRect(rect)
        //KVC  KVO   OBSERVER
        self.setValue(UIColor.whiteColor().CGColor, forKeyPath: "placeholderLabel.textColor")
    }
}
