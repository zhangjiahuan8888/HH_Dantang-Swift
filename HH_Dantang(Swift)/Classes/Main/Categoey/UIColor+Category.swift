//
//  UIColor+Category.swift
//  DSWeibo
//
//  Created by xiaomage on 15/9/14.
//  Copyright © 2015年 小码哥. All rights reserved.
//

import UIKit

extension UIColor
{
    class func randomColor() -> UIColor {
        return UIColor(red: randomNumber(), green: randomNumber(), blue: randomNumber() , alpha: 1.0)
    }
    
    class func randomNumber() -> CGFloat {
        // 0 ~ 255
        return CGFloat(arc4random_uniform(256)) / CGFloat(255)
    }
}