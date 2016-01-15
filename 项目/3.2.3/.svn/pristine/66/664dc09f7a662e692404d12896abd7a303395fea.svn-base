//
//  HWTeamworkCityListController.swift
//  Partner-Swift
//
//  Created by hw500028 on 15/3/18.
//  Copyright (c) 2015年 caijingpeng.haowu. All rights reserved.
//

import UIKit

class HWTeamworkCityListController: HWBaseViewController,UITableViewDataSource,UITableViewDelegate {
    var selectCityCell:((city:String) -> ())?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = Utility.navTitleView("合作城市")
        let cityListView = HWBaseRefreshView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: contentHeight))
        cityListView.baseTable.dataSource = self
        cityListView.baseTable.delegate = self
        cityListView.baseTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        cityListView.baseTable.rowHeight = 44
        view.addSubview(cityListView)
    }
    
// MARK:---tableViewDelegate
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return  HWUserLogin.currentUserLogin().cities.count
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        let cityClass = HWUserLogin.currentUserLogin().cities[indexPath.row] as HWCityClass
        cell.textLabel?.text = cityClass.cityName
        if indexPath.row == 0
        {
            cell.contentView.drawTopLine()
        }
        cell.contentView.drawBottomLine()
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cityClass = HWUserLogin.currentUserLogin().cities[indexPath.row] as HWCityClass
        self.navigationController?.popViewControllerAnimated(true)
        if (selectCityCell == nil) == false
        {
            selectCityCell?(city: cityClass.cityName!)
            HWUserLogin.currentUserLogin().cityId = cityClass.cityId!
            HWCoreDataManager.saveUserInfo()

        }
        
    }
}
