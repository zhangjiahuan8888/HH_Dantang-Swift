//
//  HHBannerModel.swift
//  HH_Dantang(Swift)
//
//  Created by 张家欢 on 16/8/10.
//  Copyright © 2016年 zhangjiahuan. All rights reserved.
//

import UIKit

class HHBannerModel: NSObject {
   
    var image_url : String?
    
    init(dict: [String: AnyObject]) {
        image_url = dict["image_url"] as? String
        
    }

}
