//
//  HHScrollView.swift
//  HHAdScrollView_Swift
//
//  Created by 张家欢 on 16/8/19.
//  Copyright © 2016年 zhangjiahuan. All rights reserved.
//

import UIKit
import Kingfisher

class HHScrollView: UIView, UIScrollViewDelegate {

    var pageChangeDelegate:PageChangeDelegate?
    //记录当前的page
    var currentPage = 0
    var photos:[String]?
    var autoScroll = true
    var nsTimer:NSTimer?
    var scrollView:UIScrollView!
    
    override init(frame:CGRect){
        super.init(frame: frame)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {

    }
    
    func initView(){
        
        scrollView = UIScrollView(frame: CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height))
        scrollView?.backgroundColor = UIColor.whiteColor()
        self.addSubview(scrollView!)
        scrollView!.delegate = self
        scrollView!.pagingEnabled = true
        scrollView!.showsHorizontalScrollIndicator = false
        scrollView!.showsVerticalScrollIndicator = true
        for i in 0 ..< 3 {
            let view = UIImageView(frame: CGRectMake(self.bounds.width*CGFloat(i), 0, self.bounds.width, self.bounds.height))
            view.contentMode = UIViewContentMode.ScaleToFill
            print(photos?.count)
            var imageUrl:NSURL?
            if i == 0 && photos?.count > 1{
                imageUrl = NSURL(string: photos![photos!.count-1])
            }else if i == 2 && photos?.count > 1 {
                imageUrl = NSURL(string: photos![1])
            }else{
                imageUrl = NSURL(string: photos![0])
            }
            
            view.kf_setImageWithURL(imageUrl!)
            scrollView!.addSubview(view)
            
        }
        
        scrollView!.contentSize = CGSizeMake(self.bounds.width*CGFloat(photos!.count), 0)
        scrollView!.setContentOffset(CGPoint(x: self.bounds.width, y: 0), animated: false)
        
        if autoScroll{
            
            nsTimer = NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: #selector(HHScrollView.startScroll), userInfo: nil, repeats: true)
        }
        
        //下方小圆点 pageControl
        pageControl.numberOfPages = (photos?.count)!
        self.addSubview(pageControl)
        pageControl.snp_makeConstraints { (make) in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self)
            make.height.equalTo(50)
        }

    }
    
    private lazy var pageControl: UIPageControl = {
        let pageC = UIPageControl()
        pageC.backgroundColor = UIColor.init(white: 0.5, alpha: 0.3)
        pageC.currentPage = 0
        return pageC
    }()

    func showPageIndex(index:Int){
        
        if index > currentPage{
            
            scrollView!.setContentOffset(CGPointMake(self.bounds.width*2, 0), animated: true)
        }else{
            scrollView!.setContentOffset(CGPointMake(0, 0), animated: true)
        }
    }
    
    func setDataSource(photos:[String]!){
        self.photos = photos
        
        let chilrenviews = self.subviews
        for chilren in chilrenviews {
            chilren.removeFromSuperview()
        }
        initView()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if abs((scrollView.contentOffset.x - self.bounds.width)) >= self.bounds.width{
            
            if scrollView.contentOffset.x == 0{
                currentPage  = currentPage - 1
                if currentPage == -1 {
                    
                    currentPage = photos!.count-1
                }
            }else{
                
                currentPage =  currentPage + 1
                if currentPage == photos!.count{
                    currentPage = 0
                }
                
            }
            pageControl.currentPage = currentPage
            pageChangeDelegate?.pageChange(currentPage)
            
            scrollView.setContentOffset(CGPoint(x: self.bounds.width, y: 0), animated: false)
            let imageView =  scrollView.subviews[1] as! UIImageView

            imageView.kf_setImageWithURL(NSURL(string: photos![currentPage])!)
            let leftImageView = scrollView.subviews[0] as! UIImageView
            if currentPage-1 == -1{
                
                leftImageView.kf_setImageWithURL(NSURL(string: photos![photos!.count-1])!)
            }else{
                leftImageView.kf_setImageWithURL(NSURL(string: photos![currentPage-1])!)
            }
            let rightImageView = scrollView.subviews[2] as! UIImageView
            if currentPage+1 == photos!.count {
                rightImageView.kf_setImageWithURL(NSURL(string: photos![0])!)
            }else{
                rightImageView.kf_setImageWithURL(NSURL(string: photos![currentPage+1])!)
            }
        }
        
        
    }
    
    func startScroll(){
        self.showPageIndex(currentPage+1)
    }
    
    func stopScroll(){
        nsTimer?.invalidate()
    }
    
    func setBannerViewAutoScroll(autoScroll:Bool){
        self.autoScroll = autoScroll
        if !autoScroll{
            stopScroll()
        }
    }
}
protocol PageChangeDelegate{
    
    func pageChange(index:Int)
}
