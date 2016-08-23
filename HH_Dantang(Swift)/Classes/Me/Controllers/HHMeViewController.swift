//
//  HHMeViewController.swift
//  HH_Dantang(Swift)
//
//  Created by 张家欢 on 16/8/5.
//  Copyright © 2016年 zhangjiahuan. All rights reserved.
//

import UIKit

class HHMeViewController: HHBaseViewController {

    var cellCount = 0
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }

    private func setupTableView() {
        let tableView = UITableView()
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
        view.addSubview(tableView)
    }
    
    //头视图
    private lazy var headerView: HHMeHeaderView = {
        let headerView = HHMeHeaderView()
        headerView.frame = CGRectMake(0, 0, KSCREENWIDTH, kYMMineHeaderImageHeight)
        return headerView
    }()
    //尾视图
    private lazy var footerView: HHMeFooterView = {
        let footerView = HHMeFooterView()
        footerView.width = KSCREENWIDTH
        footerView.height = 200
        return footerView
    }()
}

extension HHMeViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        return cell
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            var tempFrame = headerView.bgImgView.frame
            tempFrame.origin.y = offsetY
            tempFrame.size.height = kYMMineHeaderImageHeight - offsetY
            headerView.bgImgView.frame = tempFrame
        }
        
    }
}