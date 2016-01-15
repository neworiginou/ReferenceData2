//
//  ChatListViewController.swift
//  家教
//
//  Created by goofygao on 15/10/21.
//  Copyright © 2015年 goofyy. All rights reserved.
//

import UIKit

class ChatListViewController: UIViewController {

    @IBOutlet weak var chatTableView: UITableView!
    let reuseIdentifierString = "cell"
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigation设置
        self.chatTableView.delegate = self
        self.chatTableView.dataSource = self
        let nib = UINib(nibName: "ChatListTableViewCell", bundle: nil)
        self.chatTableView.registerNib(nib, forCellReuseIdentifier: reuseIdentifierString)
        let navBar = self.navigationController?.navigationBar
        navBar?.barTintColor = UIColor(red: 65.0 / 255.0, green: 62.0 / 255.0, blue: 79.0 / 255.0, alpha: 1)
        navBar?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.title = "好友列表"
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
//        self.navigationController?.interactivePopGestureRecognizer?.delegate = self

    }
    
//    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer!) -> Bool {
//        return false;
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension ChatListViewController:UITableViewDelegate,UITableViewDataSource {
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifierString, forIndexPath: indexPath) as! ChatListTableViewCell
//        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    internal func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       let storyBoadrd = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let chatViewstoryBoard:ChatViewController = storyBoadrd.instantiateViewControllerWithIdentifier("chatContentView") as! ChatViewController
        self.navigationController?.pushViewController(chatViewstoryBoard, animated: true)
        
//        self.navigationController?.presentViewController(ChatViewController(), animated: true, completion: nil)
    
    }
    
    
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    
    
    
}
