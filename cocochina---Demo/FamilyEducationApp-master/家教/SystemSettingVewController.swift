//
//  SystemSettingVewController.swift
//  家教
//
//  Created by goofygao on 15/11/4.
//  Copyright © 2015年 goofyy. All rights reserved.
//

import UIKit

class SystemSettingVewController: UITableViewController {

    @IBOutlet weak var settingTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 65.0 / 255.0, green: 62.0 / 255.0, blue: 79.0 / 255.0, alpha: 1)
        let navBar = self.navigationController?.navigationBar
        navBar?.barTintColor = UIColor(red: 65.0 / 255.0, green: 62.0 / 255.0, blue: 79.0 / 255.0, alpha: 1)
        navBar?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]

        settingTableView.tableHeaderView = UIView(frame: CGRectMake(0,0,DeviceData.width,0))
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        let section = indexPath.section
        switch section {
        case 0:
            if indexPath.row == 0 {
                cell?.textLabel?.text = "消息设置"
            } else if indexPath.row == 1 {
                cell?.textLabel?.text = "账号设置"
            }else {
                cell?.textLabel?.text = "隐私设置"
            }
            cell?.detailTextLabel?.text = nil
            break
        default:
            cell?.detailTextLabel?.font = UIFont.systemFontOfSize(12)
            if indexPath.row == 0 {
                cell?.textLabel?.text = "反馈问题"
                cell?.detailTextLabel?.text = nil
            } else if indexPath.row == 1 {
                cell?.textLabel?.text = "版本更新"
                cell?.detailTextLabel?.text = "Version 1.0.3"
            }else {
                cell?.textLabel?.text = "关于我们"
                
                cell?.detailTextLabel?.text = "iHat工作室"
            }
            
            
            break
            
        }
        cell?.textLabel?.backgroundColor = UIColor.clearColor()
        cell?.detailTextLabel?.backgroundColor = UIColor.clearColor()
        cell?.backgroundColor = UIColor(white: 0.9, alpha: 1)
        return cell!
    }
    
   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
        
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "通用设置"
        } else {
            return "关于软件"
        }
    }
    
   override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
   override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
}




