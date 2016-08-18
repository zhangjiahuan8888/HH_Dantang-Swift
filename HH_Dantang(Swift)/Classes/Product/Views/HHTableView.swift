//
//  HHTableView.swift
//  HH_Dantang(Swift)
//
//  Created by 张家欢 on 16/8/17.
//  Copyright © 2016年 zhangjiahuan. All rights reserved.
//

import UIKit

class HHTableView: UITableView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer,
                             shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool{
        return true
    }
}
