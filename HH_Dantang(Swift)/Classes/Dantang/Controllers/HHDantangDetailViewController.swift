//
//  HHDantangDetailViewController.swift
//  HH_Dantang(Swift)
//
//  Created by 张家欢 on 16/8/16.
//  Copyright © 2016年 zhangjiahuan. All rights reserved.
//

import UIKit
import Kingfisher
class HHDantangDetailViewController: HHBaseViewController {

    var homeItem: HHHomeItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        let webView = UIWebView()
        webView.frame = view.bounds
        //自动对网页进行缩放以适应屏幕
        webView.scalesPageToFit = true
        webView.backgroundColor = UIColor.clearColor()
        webView.opaque = false
        webView.scrollView.contentInset = UIEdgeInsetsMake(180, 0, 0, 0);
        let url = NSURL(string: (homeItem?.content_url)!)
        let request = NSURLRequest(URL: url!)
     
        let headerView = UIImageView()
        headerView.backgroundColor = UIColor.cyanColor()
        headerView.kf_setImageWithURL(NSURL(string: (homeItem?.cover_image_url)!)!)
        
        headerView.frame = CGRectMake(0, -180, webView.frame.size.width, 180)
        webView.scrollView.addSubview(headerView)
        webView.delegate = self
        webView.scrollView.delegate = self
        webView.loadRequest(request)
        view.addSubview(webView)
        
        view.addSubview(toolBar)
        toolBar.snp_makeConstraints { (make) in
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view)
            make.height.equalTo(42)
        }
    }

    lazy var toolBar : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        
        let topline = UIView()
        topline.backgroundColor = UIColor.darkGrayColor()
        topline.frame = CGRectMake(0, 0, KSCREENWIDTH, 0.5)
        view.addSubview(topline)
        
        let leftLine = UIView()
        leftLine.backgroundColor = UIColor.lightGrayColor()
        leftLine.frame = CGRectMake(KSCREENWIDTH/3, 11, 0.5, 20)
        view.addSubview(leftLine)
        
        let rightLine = UIView()
        rightLine.backgroundColor = UIColor.lightGrayColor()
        rightLine.frame = CGRectMake(2*KSCREENWIDTH/3, 11, 0.5, 20)
        view.addSubview(rightLine)
        
        return view
    }()
}

extension HHDantangDetailViewController: UIWebViewDelegate,UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }

}