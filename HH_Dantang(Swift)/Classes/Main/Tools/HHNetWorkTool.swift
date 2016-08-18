//
//  HHNetWorkTool.swift
//  HH_Dantang(Swift)
//
//  Created by 张家欢 on 16/8/5.
//  Copyright © 2016年 zhangjiahuan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HHNetWorkTool: NSObject {
    ///单例
    static let shareNetworkTool = HHNetWorkTool()
    
    //获取精选页轮播图数据
    func loadBannerData(finished:(hh_bannerModels: [HHBannerModel]) -> ()) {
        let url = BASE_URL + "v1/banners"
        let params = ["channel":"iOS"]
        Alamofire.request(.GET, url,parameters: params).responseJSON { (response) in
            if let value = response.result.value{
                let dict = JSON(value)
                let data = dict["data"].dictionary
                if let banners = data!["banners"]?.arrayObject {
                    
                    var bannerModels = [HHBannerModel]()
                    
                    for banner in banners {
                        let bannerModel = HHBannerModel(dict: banner as! [String: AnyObject])
                        bannerModels.append(bannerModel)
                    }
                    
                    finished(hh_bannerModels: bannerModels)
                }
                
            }

        }
    }
    
    //获取精选页面列表数据
    /*数据目标格式
     [  {"01.01":["item","item"]},
        {"12.30":["item","item"]},
        {"12.29":["item","item"]},
        {"12.28":["item","item"]},
        {"12.27":["item","item"]},
     ]
    */
    func loadHomeFeatureInfo(id: Int, finished:(homeItems: [[Int:[HHHomeItem]]]) -> ()) {
        let url = BASE_URL + "v1/channels/\(id)/items"
        let params = ["gender": 1,
                      "generation": 1,
                      "limit": 20,
                      "offset": 0]
        Alamofire.request(.GET, url,parameters: params).responseJSON { (response) in
            
            if let value = response.result.value {
                let dict = JSON(value)
                let data = dict["data"].dictionary

                if let items = data!["items"]?.arrayObject {
                    
                    var homeItemDic = [Int:[HHHomeItem]]()
                    for item in items{
                        let homeItem = HHHomeItem(dict: item as! [String: AnyObject])
                        
                        if var itemArr =  homeItemDic[homeItem.created_at!] {
                            itemArr.append(homeItem)
                            homeItemDic[homeItem.created_at!] = itemArr;
                        }else{
                            var itemArr =  [HHHomeItem]()
                            itemArr.append(homeItem)
                            homeItemDic[homeItem.created_at!] = itemArr;
                        }
                    }
                    
                    //按照键升序排序  
                    let arrTemp = homeItemDic.sort({ (t1, t2) -> Bool in
                        return t1.0 > t2.0 ? true:false
                    })
                    var finishItems = [[Int:[HHHomeItem]]]()
                    for (k,v) in arrTemp{  
                        let dic = [k:v]
                        finishItems.append(dic)
                    }
                    finished(homeItems: finishItems)
                }
                
            }
        }
    }

    //获取首页顶部标题数据
    func loadHomeTopData(finished:(hh_channels: [HHChannel]) -> ()){
        let url = BASE_URL + "v2/channels/preset"
        let params = ["gender": 1,
                      "generation": 1]
        
        Alamofire.request(.GET, url,parameters: params).responseJSON { (response) in
            
            if let value = response.result.value{
                let dict = JSON(value)
                let data = dict["data"].dictionary
                if let channels = data!["channels"]?.arrayObject {
                    var channelModels = [HHChannel]()
                    for channel in channels {
                        let channelModel = HHChannel(dict: channel as! [String: AnyObject])
                        channelModels.append(channelModel)
                    }
                    
                    finished(hh_channels: channelModels)
                }
            
            }
        }
        
    }
    
    //获取首页列表数据（精选除外）
    func loadHomeInfo(id: Int, finished:(homeItems: [HHHomeItem]) -> ()) {
        let url = BASE_URL + "v1/channels/\(id)/items"
        let params = ["gender": 1,
                      "generation": 1,
                      "limit": 20,
                      "offset": 0]
        Alamofire.request(.GET, url,parameters: params).responseJSON { (response) in
            
            if let value = response.result.value {
                let dict = JSON(value)
                let data = dict["data"].dictionary
                if let items = data!["items"]?.arrayObject {
                    var homeItems = [HHHomeItem]()
                    for item in items{
                        let homeItem = HHHomeItem(dict: item as! [String: AnyObject])
                        homeItems.append(homeItem)
                    }
                    finished(homeItems: homeItems)
                }
                
            }
        }
    }
    
    //获取单品数据
    func loadProductData(finished:(products: [HHProductModel]) -> ()){
        let url = BASE_URL + "v2/items"
        let params = ["gender": 1,
                      "generation": 1,
                      "limit": 20,
                      "offset": 0]
        
        Alamofire.request(.GET, url, parameters: params).responseJSON { (response) in
            
            if let value = response.result.value{
                let dict = JSON(value)
                let data = dict["data"].dictionary
                if let items = data!["items"]?.arrayObject{
                    var productModels = [HHProductModel]()
                    for item in items{
                        if let itemData = item["data"]{
                        
                            let productModel = HHProductModel(dict: itemData as! [String: AnyObject])
                            productModels.append(productModel)
                        }
                    }
                    finished(products: productModels)
                }
            }
        }
    
    
    }
}
