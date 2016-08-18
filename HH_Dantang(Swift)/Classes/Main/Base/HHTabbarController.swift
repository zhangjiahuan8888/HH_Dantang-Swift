//
//  HHTabbarController.swift
//  HH_Dantang(Swift)
//
//  Created by 张家欢 on 16/8/5.
//  Copyright © 2016年 zhangjiahuan. All rights reserved.
//

import UIKit

class HHTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = HHGlobalRedColor()
        addChildController(HHDantanController(), title: "单糖", imgName: "TabBar_home_23x23_", selectImgName: "TabBar_home_selected_23x23_")
        addChildController(HHProductController(), title: "单品", imgName: "TabBar_gift_23x23_", selectImgName: "TabBar_gift_selected_23x23_")
        addChildController(HHClassifyController(), title: "分类", imgName: "TabBar_category_23x23_", selectImgName: "TabBar_category_Selected_23x23_")
        addChildController(HHMeViewController(), title: "我", imgName: "TabBar_me_boy_23x23_", selectImgName: "TabBar_me_boy_selected_23x23_")
    }

    func addChildController(childVC:UIViewController, title:String, imgName:String, selectImgName:String) {
        let childNav = HHNavigationController(rootViewController: childVC)
        childVC.title = title;
        childVC.tabBarItem.image = UIImage(named: imgName)
        childVC.tabBarItem.selectedImage = UIImage(named: selectImgName)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        addChildViewController(childNav)
    }


}
