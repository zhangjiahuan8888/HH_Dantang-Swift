//
//  HHChannel.swift
//  HH_Dantang(Swift)
//
//  Created by 张家欢 on 16/8/10.
//  Copyright © 2016年 zhangjiahuan. All rights reserved.
//

import Foundation

class HHChannel: NSObject {
    var editable : Bool?
    var id : Int?
    var name : String?

    init(dict: [String: AnyObject]) {
        id = dict["id"] as? Int
        name = dict["name"] as? String
        editable = dict["editable"] as? Bool
    }
}
