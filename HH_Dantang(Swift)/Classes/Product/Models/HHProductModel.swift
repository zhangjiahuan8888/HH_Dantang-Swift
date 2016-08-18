//
//  HHProductModel.swift
//  HH_Dantang(Swift)
//
//  Created by 张家欢 on 16/8/5.
//  Copyright © 2016年 zhangjiahuan. All rights reserved.
//

import UIKit

class HHProductModel: NSObject {
    var cover_image_url: String?
    var name: String?
    var price: String?
    var favorites_count: Int?
    
    init(dict: [String: AnyObject]) {
        super.init()
        cover_image_url = dict["cover_image_url"] as? String
        name = dict["name"] as? String
        price = dict["price"] as? String
        favorites_count = dict["favorites_count"] as? Int
    }
}
