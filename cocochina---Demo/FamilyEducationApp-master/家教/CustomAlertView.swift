//
//  CustomAlertView.swift
//  家教
//
//  Created by goofygao on 15/11/23.
//  Copyright © 2015年 goofyy. All rights reserved.
//

import UIKit

class CustomAlertView: UIView {

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.layer.cornerRadius = 2
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor(white: 0, alpha: 0.4)
//        UIColor(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadAlertView() -> UIView {
        let acitivityView = UIActivityIndicatorView()
        acitivityView.center.x = self.center.x
        acitivityView.center.y = self.center.y - 10
        acitivityView.frame.size = CGSizeMake(50, 50)
        self.addSubview(acitivityView)
        acitivityView.startAnimating()
        
        let title = UILabel()
        title.text = "加载中..."
        title.font = UIFont.systemFontOfSize(14)
        title.frame = CGRectMake(0, self.frame.height - 21, self.frame.width, self.frame.height)
        title.textColor = UIColor(white: 0.8, alpha: 0.9)
        self.addSubview(title)
        return self
        
    }
    
}
