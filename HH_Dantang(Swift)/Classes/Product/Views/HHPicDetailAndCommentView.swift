//
//  HHPicDetailAndCommentView.swift
//  HH_Dantang(Swift)
//
//  Created by 张家欢 on 16/8/17.
//  Copyright © 2016年 zhangjiahuan. All rights reserved.
//

import UIKit

class HHPicDetailAndCommentView: UIView {

    var tabTitleView : UIView!
    var tabContentView : UITableView!
    var webView : UIWebView!
    var canScroll = false
    deinit {
        //记得移除通知监听
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.userInteractionEnabled = true
        
        setupUI()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HHPicDetailAndCommentView.acceptNotification(_:)), name: kGoTopNotificationName, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HHPicDetailAndCommentView.acceptNotification(_:)), name: kLeaveTopNotificationName, object: nil)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        tabTitleView = UIView()
        tabTitleView.frame = CGRectMake(0, 0, KSCREENWIDTH, kTabTitleViewHeight)
        tabTitleView.backgroundColor = UIColor.redColor()
        self.addSubview(tabTitleView)
        
        let picDetailBtn = UIButton(type: UIButtonType.Custom)
        picDetailBtn.setTitle("图文详情", forState: UIControlState.Normal)
        picDetailBtn.frame = CGRectMake(0, 0, KSCREENWIDTH/2, kTabTitleViewHeight);
        picDetailBtn.addTarget(self, action: #selector(HHPicDetailAndCommentView.clickPicDetail), forControlEvents: UIControlEvents.TouchUpInside)
        tabTitleView.addSubview(picDetailBtn)

        let commentBtn = UIButton(type: UIButtonType.Custom)
        commentBtn.setTitle("评价", forState: UIControlState.Normal)
        commentBtn.frame = CGRectMake(KSCREENWIDTH/2, 0, KSCREENWIDTH/2, kTabTitleViewHeight);
        commentBtn.addTarget(self, action: #selector(HHPicDetailAndCommentView.clickComment), forControlEvents: UIControlEvents.TouchUpInside)
        tabTitleView.addSubview(commentBtn)
        
        //评论视图
        tabContentView = UITableView(frame: CGRectMake(0, CGRectGetMaxY(tabTitleView.frame), KSCREENWIDTH, self.height - tabTitleView.height), style: UITableViewStyle.Plain)
        tabContentView.backgroundColor = UIColor.greenColor()
        tabContentView.dataSource = self
        tabContentView.delegate = self
        tabContentView.hidden = true
        self.addSubview(tabContentView)
        tabContentView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        //图文详情
//        webView = UIWebView(frame: CGRectMake(0, CGRectGetMaxY(tabTitleView.frame), KSCREENWIDTH, CGRectGetHeight(self.frame) - CGRectGetHeight(tabTitleView.frame)))
//        webView.backgroundColor = UIColor.redColor()
//        webView.scrollView.delegate = self;
//        self.addSubview(webView)
//        let url = NSURL(string: "http://www.jianshu.com/p/38f0b7eef959")
//        let request = NSURLRequest(URL: url!)
//        webView.loadRequest(request)
        

        
    }
    
    func clickPicDetail() {
     print("点击了图文详情")
//        webView.hidden = false
        tabContentView.hidden = true
    }
    
    func clickComment() {
        print("点击了评价")
//        webView.hidden = true
        tabContentView.hidden = false

    }

    func acceptNotification(notification: NSNotification) {
        let notificationName = notification.name as String
        if notificationName.isEqual(kGoTopNotificationName) {
            let userInfo = notification.userInfo
            let canS = userInfo!["canScroll"]
            if (canS?.isEqual("1")) != nil {
                self.canScroll = true
                tabContentView.showsVerticalScrollIndicator = true
            }
        }else if notificationName.isEqual(kLeaveTopNotificationName){
            tabContentView.contentOffset = CGPointZero
            self.canScroll = false
            tabContentView.showsVerticalScrollIndicator = false
        }
    }
}

extension HHPicDetailAndCommentView:UITableViewDelegate,UITableViewDataSource{

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        cell?.textLabel?.text = "评价"
        return cell!
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
//        print("下方tableview")
//        print("____\(canScroll)")
        if !canScroll {
            scrollView.contentOffset = CGPointZero
            print("canScroll__\(canScroll)")
        }
        
        let offsetY = scrollView.contentOffset.y
        
        if offsetY < 0 {
            NSNotificationCenter.defaultCenter().postNotificationName(kLeaveTopNotificationName, object: nil, userInfo: ["canScroll":"1"])

        }
        
    }
}
