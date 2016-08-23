//
//  HHMeFooterView.swift
//  HH_Dantang(Swift)
//
//  Created by 张家欢 on 16/8/23.
//  Copyright © 2016年 zhangjiahuan. All rights reserved.
//

import UIKit

class HHMeFooterView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        addSubview(loginBtn)
        addSubview(loginLabel)
        
        loginBtn.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(50, 50))
            make.center.equalTo(self)
        }
        loginLabel.snp_makeConstraints { (make) in
            make.top.equalTo(loginBtn.snp_bottom).offset(kMargin)
            make.left.right.equalTo(self)
        }
    }
    
    private lazy var loginBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Me_blank_50x50_"), forState: .Normal)
        return button
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = "登录已享受功能"
        label.font = UIFont.systemFontOfSize(15)
        label.textAlignment = NSTextAlignment.Center
        return label
    }()
}
