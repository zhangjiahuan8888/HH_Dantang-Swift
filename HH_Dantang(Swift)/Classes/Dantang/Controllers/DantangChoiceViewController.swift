//
//  DantangChoiceViewController.swift
//  HH_Dantang(Swift)
//
//  Created by 张家欢 on 16/8/8.
//  Copyright © 2016年 zhangjiahuan. All rights reserved.
//

import UIKit
import Alamofire

let HHDantangChoiceCellIdentifier = "HHDantangChoiceCellIdentifier"
class DantangChoiceViewController: UITableViewController {

    var type = Int()
    var items = [[Int:[HHHomeItem]]]()
    var refreshCtrl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = HHGlobalColor()
        setupTableView()
        
        weak var weakSelf = self
        //获取精选页面轮播图的数据
        HHNetWorkTool.shareNetworkTool.loadBannerData { (hh_bannerModels) in
            var imgUrlArr = [String]()
            for bannerModel in hh_bannerModels{
                let imgUrl = bannerModel.image_url
                imgUrlArr.append(imgUrl!)
            }
            weakSelf!.setupTableViewHeaderView(imgUrlArr)
        }
        
        //获取精选页面列表数据
        HHNetWorkTool.shareNetworkTool.loadHomeFeatureInfo(type) { (homeItems) in
            weakSelf?.items = homeItems
            weakSelf?.tableView.reloadData()
        }
    }
    
    func setupTableView(){
        tableView.rowHeight = 160
        tableView.separatorStyle = .None
        tableView.contentInset = UIEdgeInsetsMake(0, 0, tabBarController!.tabBar.height+5, 0)
        tableView.registerClass(HHDanTangCell.self, forCellReuseIdentifier: HHDantangChoiceCellIdentifier)
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: #selector(DantangChoiceViewController.refreshData),
                                 forControlEvents: UIControlEvents.ValueChanged)
//        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新数据")
        tableView.addSubview(refreshControl!)
        
    }
    
    func setupTableViewHeaderView(imgArr:[String]){

        let bannerView = HHBannerView(frame: CGRectMake(0, 0, KSCREENWIDTH, 150), withBannerSource: 1, withBannerArray: imgArr)
        bannerView.showPageControl = true
        bannerView.timeInterval = 3
        tableView.tableHeaderView = bannerView
        
    }
  
    func refreshData() {

        self.items.removeAll()
        weak var weakSelf = self
        HHNetWorkTool.shareNetworkTool.loadHomeFeatureInfo(type) { (homeItems) in
            weakSelf?.items = homeItems
            weakSelf?.tableView.reloadData()
            self.refreshControl!.endRefreshing()
        }

    }
}

extension DantangChoiceViewController{
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return items.count ?? 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dic = items[section]
        var arr = [HHHomeItem]()
        
        for key in dic.keys {
            arr = dic[key]!
        }
        return arr.count ?? 0
    }
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let dic = items[section]
        let index = dic.keys.first
        let headerView = HHHomeHeaderView(frame: CGRectMake(0, 0, KSCREENWIDTH, 50), creat_at: index!)
        return headerView
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(HHDantangChoiceCellIdentifier) as! HHDanTangCell
        let dic = items[indexPath.section]
        var arr = [HHHomeItem]()
        arr = dic[dic.keys.first!]!
        cell.homeItem = arr[indexPath.row]
        
//        if (indexPath.row == self.items.count-1) {
//
//            loadMore()
//        }
        return cell
    }
    func loadMore(){
        print("loadMore")
//        self.data = self.data.arrayByAddingObjectsFromArray(self.newData as! [String])
        self.tableView.reloadData()
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailVC = HHDantangDetailViewController()
        let dic = items[indexPath.section]
        var arr = [HHHomeItem]()
        arr = dic[dic.keys.first!]!
        detailVC.homeItem = arr[indexPath.row]
        detailVC.title = "攻略详情"
        navigationController?.pushViewController(detailVC, animated: true)
    }

    //设置plain模式下后视图浮动效果
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView == self.tableView  {
            let sectionHeaderHeight = CGFloat(50)
            if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
                scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
                } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
                scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 49, 0);
                }
            }
        }
    }
