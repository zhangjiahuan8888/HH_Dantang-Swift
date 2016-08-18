//
//  HHHomeHeaderView.swift
//  HH_Dantang(Swift)
//
//  Created by 张家欢 on 16/8/11.
//  Copyright © 2016年 zhangjiahuan. All rights reserved.
//

import UIKit

class HHHomeHeaderView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    init(frame: CGRect,creat_at:Int) {
        super.init(frame: frame)
        backgroundColor = HHGlobalColor()
        let backView = UIView()
        backView.backgroundColor = UIColor.whiteColor()
        addSubview(backView)
        backView.snp_makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(self).offset(10)
            make.width.equalTo(KSCREENWIDTH)
            make.bottom.equalTo(self)
        }
        
        let redLineView = UIView()
        redLineView.backgroundColor = HHGlobalRedColor()
        backView.addSubview(redLineView)
        redLineView.snp_makeConstraints { (make) in
            make.left.equalTo(self)
            make.width.equalTo(4)
            make.height.equalTo(20)
            make.centerY.equalTo(backView)
        }
        
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(14)
        label.text = NSDate.timeStampToString(String(creat_at))
        backView.addSubview(label)
        label.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(backView)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
