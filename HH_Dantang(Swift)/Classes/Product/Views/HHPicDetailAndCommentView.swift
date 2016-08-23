//
//  HHPicDetailAndCommentView.swift
//  HH_Dantang(Swift)
//
//  Created by 张家欢 on 16/8/17.
//  Copyright © 2016年 zhangjiahuan. All rights reserved.
//

import UIKit

class HHPicDetailAndCommentView: UIView {

    var comments = [HHProductCommentModel]()
    var product: HHProductModel? {
        didSet {

            weak var weakSelf = self
            //获取单品详情webview数据
            HHNetWorkTool.shareNetworkTool.loadProductDetailData((product?.id)!) { (productDetail) in
                weakSelf?.webView.loadHTMLString(productDetail.detail_html!, baseURL: nil)
            }
            
            //获取评论数据
            HHNetWorkTool.shareNetworkTool.loadProductDetailCommmentData((product?.id)!) { (comments) in
                weakSelf?.comments = comments
                weakSelf?.tabContentView.reloadData()
            }
            
        }
    }

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
        tabTitleView.backgroundColor = UIColor.whiteColor()
        self.addSubview(tabTitleView)
        
        let picDetailBtn = UIButton(type: UIButtonType.Custom)
        picDetailBtn.setTitle("图文详情", forState: UIControlState.Normal)
        picDetailBtn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        picDetailBtn.frame = CGRectMake(0, 0, KSCREENWIDTH/2, kTabTitleViewHeight);
        picDetailBtn.addTarget(self, action: #selector(HHPicDetailAndCommentView.clickPicDetail), forControlEvents: UIControlEvents.TouchUpInside)
        tabTitleView.addSubview(picDetailBtn)

        let commentBtn = UIButton(type: UIButtonType.Custom)
        commentBtn.setTitle("评价", forState: UIControlState.Normal)
        commentBtn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        commentBtn.frame = CGRectMake(KSCREENWIDTH/2, 0, KSCREENWIDTH/2, kTabTitleViewHeight);
        commentBtn.addTarget(self, action: #selector(HHPicDetailAndCommentView.clickComment), forControlEvents: UIControlEvents.TouchUpInside)
        tabTitleView.addSubview(commentBtn)
        
        //评论视图
        tabContentView = UITableView(frame: CGRectMake(0, CGRectGetMaxY(tabTitleView.frame), KSCREENWIDTH, self.height - tabTitleView.height), style: UITableViewStyle.Plain)
        tabContentView.backgroundColor = UIColor.whiteColor()
        tabContentView.dataSource = self
        tabContentView.delegate = self
        tabContentView.hidden = true
        tabContentView.rowHeight = 60
        self.addSubview(tabContentView)
        tabContentView.registerClass(HHCommentCell.self, forCellReuseIdentifier: "cell")
        
        //图文详情
        webView = UIWebView(frame: CGRectMake(0, CGRectGetMaxY(tabTitleView.frame), KSCREENWIDTH, CGRectGetHeight(self.frame) - CGRectGetHeight(tabTitleView.frame)))
        webView.scrollView.delegate = self;
        webView.backgroundColor = UIColor.whiteColor()
        self.addSubview(webView)
        
        
    }
    
    func clickPicDetail() {
     
        webView.hidden = false
        tabContentView.hidden = true
    }
    
    func clickComment() {
        webView.hidden = true
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
        return comments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! HHCommentCell
        cell.comment = comments[indexPath.row]
        return cell
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {

        if !canScroll {
            scrollView.contentOffset = CGPointZero
        }
        
        let offsetY = scrollView.contentOffset.y
        
        if offsetY < 0 {
            NSNotificationCenter.defaultCenter().postNotificationName(kLeaveTopNotificationName, object: nil, userInfo: ["canScroll":"1"])
        }
        
    }
}
