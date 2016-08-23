//
//  HHProductDetailViewController.swift
//  HH_Dantang(Swift)
//
//  Created by 张家欢 on 16/8/10.
//  Copyright © 2016年 zhangjiahuan. All rights reserved.
//

import UIKit

class HHProductDetailViewController: HHBaseViewController {
    
    var product: HHProductModel!
    var tableView:UITableView!
    var isTopIsCanNotMoveTabView = false
    var isTopIsCanNotMoveTabViewPre = false
    var canScroll = false
    deinit {
        //记得移除通知监听
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "商品详情";
        self.automaticallyAdjustsScrollViewInsets = false
        setupUI()
        print(product!.url)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HHProductDetailViewController.acceptMsg(_:)), name:kLeaveTopNotificationName, object: nil)
    }

    private func setupUI(){

        tableView = HHTableView()
        tableView.frame = CGRectMake(0, 64, KSCREENWIDTH, KSCREENHEIGHT-64)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        view.addSubview(tableView)
        tableView.registerClass(HHProductDetailTopCell.self, forCellReuseIdentifier: "cell")
    }

    func acceptMsg(notification: NSNotification) {
        let userInfo = notification.userInfo
        let canS = userInfo!["canScroll"]
        if (canS?.isEqual("1")) != nil {
                canScroll = true
            }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension HHProductDetailViewController:UITableViewDataSource,UITableViewDelegate{

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var cellHeight:CGFloat = 0.0
        if indexPath.section == 0 {
            cellHeight = 450
        }else if indexPath.section == 1 {
            cellHeight = self.view.frame.height-CGFloat(kBottomBarHeight);
        }
        return cellHeight
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        cell?.selectionStyle = UITableViewCellSelectionStyle.None
        
        if indexPath.section == 0 {

            let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! HHProductDetailTopCell
            cell.product = self.product
            return cell
        }else  {
            
            let picAndCommentView = HHPicDetailAndCommentView(frame: CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT - CGFloat(kBottomBarHeight) ))
            picAndCommentView.product = self.product
            cell?.contentView.addSubview(picAndCommentView)

            return cell!
        }
        
    }
    
    func click(){
        print("点及了按钮")
    }
    
    }

extension HHProductDetailViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(scrollView: UIScrollView) {

        let tabOffsetY = tableView.rectForSection(1).origin.y
        let offsetY = scrollView.contentOffset.y
        isTopIsCanNotMoveTabViewPre = isTopIsCanNotMoveTabView
        if offsetY >= tabOffsetY {
            scrollView.contentOffset = CGPointMake(0, tabOffsetY)
            isTopIsCanNotMoveTabView = true
        }else{
            isTopIsCanNotMoveTabView = false
        }
        
        if isTopIsCanNotMoveTabView != isTopIsCanNotMoveTabViewPre {
            if !isTopIsCanNotMoveTabViewPre && isTopIsCanNotMoveTabView {
                NSNotificationCenter.defaultCenter().postNotificationName(kGoTopNotificationName, object: nil, userInfo: ["canScroll":"1"])
                canScroll = false
            }
            if isTopIsCanNotMoveTabViewPre && !isTopIsCanNotMoveTabView {
                
                if !canScroll  {
                    scrollView.contentOffset = CGPointMake(0, tabOffsetY)
                }
            }
        }
        
    }


}