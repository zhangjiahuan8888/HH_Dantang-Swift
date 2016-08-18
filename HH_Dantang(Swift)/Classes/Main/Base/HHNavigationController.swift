//
//  HHNavigationController.swift
//  HH_Dantang(Swift)
//
//  Created by 张家欢 on 16/8/5.
//  Copyright © 2016年 zhangjiahuan. All rights reserved.
//

import UIKit

class HHNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let naviBar = UINavigationBar.appearance()
        naviBar.barTintColor = HHGlobalRedColor()
        naviBar.tintColor = UIColor.whiteColor()
        naviBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor(),NSFontAttributeName:UIFont.systemFontOfSize(20)]
        
    }

    override func pushViewController(viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }

}
