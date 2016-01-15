//
//  HistoryActivityViewController.swift
//  家教
//
//  Created by goofygao on 15/11/30.
//  Copyright © 2015年 goofyy. All rights reserved.
//

import UIKit

class HistoryActivityViewController: UITableViewController {

    let recentActivity = ["义务家教","棠下家教","家教中心","五邑大学","礼乐家教"]
    let recentActivityTime = ["2015-10-23","2015-10-29","2015-10-30","2015-11-2","2015-11-23"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "历史活动"
        let navBar = self.navigationController?.navigationBar
        navBar?.barTintColor = UIColor(red: 65.0 / 255.0, green: 62.0 / 255.0, blue: 79.0 / 255.0, alpha: 1)
        navBar?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navBar?.tintColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentActivityTime.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        cell?.textLabel?.text = recentActivity[indexPath.row]
        cell?.detailTextLabel?.text = recentActivityTime[indexPath.row]
        
        return cell!
    }
}
