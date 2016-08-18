//
//  HHDantanController.swift
//  HH_Dantang(Swift)
//
//  Created by 张家欢 on 16/8/5.
//  Copyright © 2016年 zhangjiahuan. All rights reserved.
//

import UIKit

class HHDantanController: HHBaseViewController {
    
    let titleArr = ["精选","美食","家居","数码","美物","杂货"]
    var menuScrollView = UIScrollView()
    var contentView = UIScrollView()
    var selectBtn = UIButton()
    let buttonWidth = CGFloat(320.0/6.0)
    let kAnimationDuration = 0.25
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        self.navigationItem.title = "单糖";
        
        weak var weakSelf = self
        HHNetWorkTool.shareNetworkTool.loadHomeTopData { (hh_channels) in
            for channel in hh_channels{
                if channel.name == "精选" {
                    let vc = DantangChoiceViewController()
                    vc.title = channel.name
                    vc.type = channel.id!
                    weakSelf!.addChildViewController(vc)
                }else{
                    let vc = DantangClassifyViewController()
                    vc.title = channel.name
                    vc.type = channel.id!
                    weakSelf!.addChildViewController(vc)
                }
                
            }
//            self.addControllers()
            self.creatSubviews()
        }
        
    }
    func addControllers() {
        for title in titleArr {
            if title == "精选" {
                let vc = DantangChoiceViewController()
                vc.title = title
                addChildViewController(vc)

            }else{
                let vc = DantangClassifyViewController()
                vc.title = title
                addChildViewController(vc)

            }
        }
        
    }
    
    func creatSubviews() {
        let topView = UIView()
        topView.backgroundColor = UIColor.whiteColor()
        view.addSubview(topView)
        topView.snp_makeConstraints { (make) in
            make.left.equalTo(view)
            make.top.equalTo(view).offset(64)
            make.right.equalTo(view)
            make.height.equalTo(40)
        }
        
        topView.addSubview(arrowButton)
        arrowButton.snp_makeConstraints { (make) in
            make.top.equalTo(topView)
            make.right.equalTo(view)
            make.width.equalTo(buttonWidth)
            make.height.equalTo(40)
        }
        //添加切换频道视图（默认隐藏）
        topView.addSubview(sequenceView)
        sequenceView.snp_makeConstraints { (make) in
            make.left.equalTo(topView)
            make.top.equalTo(topView)
            make.height.equalTo(topView)
            make.width.equalTo(200)
        }
        sequenceView.hidden = true
        
        let menuScrollView = UIScrollView()
        menuScrollView.frame = CGRectMake(0, 0, view.size.width-buttonWidth, 40)
        menuScrollView.contentSize = CGSizeMake(buttonWidth * CGFloat(titleArr.count), 40)
        menuScrollView.backgroundColor = UIColor.whiteColor()
        menuScrollView.showsHorizontalScrollIndicator = false
        menuScrollView.showsVerticalScrollIndicator = false
        topView.addSubview(menuScrollView)
        self.menuScrollView = menuScrollView
        
        for count in 0..<titleArr.count {
            let button = UIButton()
            button.height = 40
            button.width = buttonWidth
            button.x = CGFloat(count) * buttonWidth
            button.tag = count
            let vc = childViewControllers[count]
            button.titleLabel!.font = UIFont.systemFontOfSize(14)
            button.setTitle(vc.title!, forState: .Normal)
            button.setTitleColor(UIColor.grayColor(), forState: .Normal)
            button.setTitleColor(UIColor.redColor(), forState: .Disabled)
            button.addTarget(self, action: #selector(titlesClick(_:)), forControlEvents: .TouchUpInside)
            menuScrollView.addSubview(button)
            //默认点击了第一个按钮
            if count == 0 {
                button.enabled = false
                selectBtn = button
                //让按钮内部的Label根据文字来计算内容
                button.titleLabel?.sizeToFit()
                indicatorView.width = button.titleLabel!.width
                indicatorView.centerX = button.centerX
            }
        }
        menuScrollView.addSubview(indicatorView)
        
        //下方管理控制器视图的滑动视图
        /**/
        let contentView = UIScrollView()
//        contentView.delaysContentTouches = false
//        contentView.canCancelContentTouches = false
        contentView.frame = CGRectMake(0, 64+40, view.width, view.height-64-40)
        contentView.delegate = self
        contentView.contentSize = CGSizeMake(contentView.bounds.width * CGFloat(childViewControllers.count), 0)
        contentView.pagingEnabled = true
        contentView.showsHorizontalScrollIndicator = false
        view.insertSubview(contentView, atIndex: 0)
        self.contentView = contentView
        //添加第一个控制器的view
        scrollViewDidEndScrollingAnimation(contentView)
     
        view.insertSubview(changeClassifyView, belowSubview: topView)
        topView.addSubview(lineView)
        
        lineView.snp_makeConstraints { (make) in
            make.width.equalTo(view.width)
            make.height.equalTo(0.3)
            make.bottom.equalTo(menuScrollView)
            make.left.equalTo(menuScrollView)
        }
    }
    //底部横线
    lazy var lineView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGrayColor()
        return view
    }()
    //底部红色指示器
    lazy var indicatorView :UIView = {
        let view = UIView()
        view.backgroundColor = HHGlobalRedColor()
        view.height = 2
        view.y = 40.0 - 2.0 - 0.3
        view.tag = -1
        return view
    }()
    //箭头按钮
    lazy var arrowButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.whiteColor()
        button .setImage(UIImage(named: "arrow_index_down_8x4_"), forState: UIControlState.Normal)
        button.addTarget(self, action:#selector(arrowButtonClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        return button
    }()
    //下拉视图
    lazy var changeClassifyView: UIView = {
        let view = UIView()
        view.backgroundColor = HHGlobalColor()
        view.frame = CGRectMake(0, 64+40-(KSCREENHEIGHT-64-40)-40, KSCREENWIDTH, KSCREENHEIGHT-64-40)
        return view
    }()
    
    //切换频道视图
    lazy var sequenceView:UIView = {
        let seView = UIView()
        let label = UILabel()
        label.text = "切换频道"
        label.textColor = UIColor.lightGrayColor()
        label.font = UIFont.systemFontOfSize(14)
        label.frame = CGRectMake(0, 0, 100, 40)
        label.textAlignment = NSTextAlignment.Center
        seView.addSubview(label)
        
        let button = UIButton()
        button .setTitle("排序或删除", forState: UIControlState.Normal)
        button.setTitle("完成", forState: UIControlState.Selected)
        button.setTitleColor(HHGlobalRedColor(), forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(14)
        button.frame = CGRectMake(UIScreen.mainScreen().bounds.width-self.buttonWidth-100, 0, 100, 40)
        seView.addSubview(button)
        return seView
    }()
    
    
    //点击箭头
    func arrowButtonClick(button:UIButton){
        button.selected = !button.selected
        UIView.animateWithDuration(kAnimationDuration) {
            button.imageView?.transform = CGAffineTransformRotate(button.imageView!.transform, CGFloat(M_PI))
        }
        
        UIView.animateWithDuration(0.5) {
            if button.selected{
                self.menuScrollView.hidden = true
                self.sequenceView.hidden = false
                self.setTabBarVisible(false, animated: true)
                self.changeClassifyView.transform = CGAffineTransformMakeTranslation(0, self.changeClassifyView.frame.height+40)
            }else{
                self.menuScrollView.hidden = false
                self.sequenceView.hidden = true
                self.setTabBarVisible(true, animated: true)
                self.changeClassifyView.transform = CGAffineTransformMakeTranslation(0, -(self.changeClassifyView.frame.height+40))
            }
        }
        
    }
    
    //显示或隐藏Tabbar
    func setTabBarVisible(visible:Bool, animated:Bool) {
        let frame = self.tabBarController?.tabBar.frame
        let offsetY = (visible ? CGFloat(-49.0) : 49.0)
        let duration:NSTimeInterval = (animated ? 0.3 : 0.0)
        if frame != nil {
            UIView.animateWithDuration(duration) {
                self.tabBarController?.tabBar.frame = CGRectOffset(frame!, 0, offsetY)
                return
            }
        }
    }
    func tabBarIsVisible() ->Bool {
        return self.tabBarController?.tabBar.frame.origin.y < CGRectGetMaxY(self.view.frame)
    }
    
    /// 标签上的按钮点击
    func titlesClick(button: UIButton) {
        // 修改按钮状态
        selectBtn.enabled = true
        button.enabled = false
        selectBtn = button
        // 让标签执行动画
        UIView.animateWithDuration(kAnimationDuration) {
            self.indicatorView.width = self.selectBtn.titleLabel!.width
            self.indicatorView.centerX = self.selectBtn.centerX
        }
        
        let xx = menuScrollView.width * CGFloat(button.tag - 1) * (buttonWidth / menuScrollView.width) - buttonWidth;
        menuScrollView.scrollRectToVisible(CGRectMake(xx, 0, menuScrollView.width, menuScrollView.frame.size.height), animated: true)
        
        var offset = contentView.contentOffset
        offset.x = CGFloat(button.tag) * contentView.width
        contentView.setContentOffset(offset, animated: true)
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("dianji")
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("huadong")
    }
}

extension HHDantanController:UIScrollViewDelegate{
    //点击button设置ContentOffset导致
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        let vc = childViewControllers[index]
        vc.view.x = scrollView.contentOffset.x
        vc.view.y = 0 // 设置控制器的y值为0(默认为20)
        vc.view.height = scrollView.height
        scrollView.addSubview(vc.view)
    }
    //滑动结束导致
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(scrollView)
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        let button = menuScrollView.subviews[index] as! UIButton
        titlesClick(button)
    }
    
}
