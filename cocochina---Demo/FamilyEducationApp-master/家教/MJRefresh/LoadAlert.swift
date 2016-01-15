//
//  LoadAlert.swift
//  GFAlertView
//
//  Created by goofygao on 15/11/27.
//  Copyright © 2015年 goofyy. All rights reserved.
//

import UIKit

class LoadAlert: UIView {

    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    @IBOutlet weak var titleLabel: UILabel!

        var i = 0
    class func instantiateFromNib() -> LoadAlert {
        let view = UINib(nibName: "LoadAlert", bundle: nil).instantiateWithOwner(nil, options: nil).first as! LoadAlert
        
        return view
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.alpha = 0.9
        activity.startAnimating()
        NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "timerAction", userInfo: nil, repeats: true)
    }
    
    func timerAction() {
        i++
        if i % 3 == 0 {
            titleLabel.text = "加载ing..."
        } else if i % 3 == 1 {
            titleLabel.text = "加载ing."
        } else if i % 3 == 2 {
            titleLabel.text = "加载ing.."
        }
    }

    
}
