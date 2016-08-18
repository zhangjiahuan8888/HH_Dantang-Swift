//
//  DantangClassifyViewController.swift
//  HH_Dantang(Swift)
//
//  Created by 张家欢 on 16/8/8.
//  Copyright © 2016年 zhangjiahuan. All rights reserved.
//

import UIKit

let HHDantangClassifyCellIdentifier = "HHDantangClassifyCellIdentifier"
class DantangClassifyViewController: UITableViewController {

    var type = Int()
    var items = [HHHomeItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = HHGlobalColor()
        setupTableView()
        
        weak var weakSelf = self
        HHNetWorkTool.shareNetworkTool.loadHomeInfo(type) { (homeItems) in
            weakSelf?.items = homeItems
            weakSelf?.tableView.reloadData()
        }
    }

    func setupTableView(){
        tableView.rowHeight = 160
        tableView.separatorStyle = .None
        tableView.contentInset = UIEdgeInsetsMake(5, 0, tabBarController!.tabBar.height+5, 0)
        tableView.registerClass(HHDantangChoiceCell.self, forCellReuseIdentifier: HHDantangClassifyCellIdentifier)
    }

}
extension DantangClassifyViewController{
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count ?? 0

    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(HHDantangClassifyCellIdentifier) as! HHDantangChoiceCell
        cell.homeItem = items[indexPath.row]
        return cell
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailVC = HHDantangDetailViewController()
//        let dic = items[indexPath.section]
//        var arr = [HHHomeItem]()
//        arr = dic[dic.keys.first!]!
        detailVC.homeItem = items[indexPath.row]
        detailVC.title = "攻略详情"
        navigationController?.pushViewController(detailVC, animated: true)
    }

}