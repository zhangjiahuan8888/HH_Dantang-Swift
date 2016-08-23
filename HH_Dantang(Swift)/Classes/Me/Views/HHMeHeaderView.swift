//
//  HHMeHeaderView.swift
//  HH_Dantang(Swift)
//
//  Created by 张家欢 on 16/8/22.
//  Copyright © 2016年 zhangjiahuan. All rights reserved.
//

import UIKit

class HHMeHeaderView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI() {
    
        addSubview(bgImgView)
        addSubview(messageBtn)
        addSubview(settingBtn)
        addSubview(iconBtn)
        addSubview(nameLabel)
        
        bgImgView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.top.equalTo(-20)
        }
        messageBtn.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(44, 44))
            make.left.equalTo(self)
            make.top.equalTo(0)
        }
        settingBtn.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(44, 44))
            make.top.equalTo(0)
            make.right.equalTo(self)
        }
        iconBtn.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.centerX)
            make.size.equalTo(CGSizeMake(75, 75))
            make.bottom.equalTo(nameLabel.snp_top).offset(-kMargin)
        }
        nameLabel.snp_makeConstraints { (make) in
            make.bottom.equalTo(self.snp_bottom).offset(-3 * kMargin)
            make.centerX.equalTo(self)
            make.height.equalTo(2 * kMargin)
        }
    }
    
    //创建背景图片
    lazy var bgImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .ScaleAspectFill
        imgView.image = UIImage(named: "Me_ProfileBackground")
        return imgView
    }()
    
    //左上角消息按钮
    lazy var messageBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "Me_message_20x20_"), forState: UIControlState.Normal)
        return btn
    }()
    
    //右上角设置按钮
    lazy var settingBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "Me_settings_20x20_"), forState: UIControlState.Normal)
        return btn
    }()

    //头像按钮
    lazy var iconBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "Me_AvatarPlaceholder_75x75_"), forState: .Normal)
        btn.layer.cornerRadius = btn.width * 0.5
        btn.layer.masksToBounds = true
        return btn
    }()

    //创建昵称标签
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "fghjk"
        nameLabel.textColor = UIColor.whiteColor()
        nameLabel.font = UIFont.systemFontOfSize(15)
        nameLabel.textAlignment = .Center
        return nameLabel
    }()
}
