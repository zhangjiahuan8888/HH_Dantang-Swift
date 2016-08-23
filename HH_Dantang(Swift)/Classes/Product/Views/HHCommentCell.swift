//
//  HHCommentCell.swift
//  HH_Dantang(Swift)
//
//  Created by 张家欢 on 16/8/22.
//  Copyright © 2016年 zhangjiahuan. All rights reserved.
//

import UIKit

class HHCommentCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var comment: HHProductCommentModel? {
        didSet{
            let user = comment?.user
            let url = user?.avatar_url
 
            imgView.kf_setImageWithURL(NSURL(string: url!)!, placeholderImage: UIImage(named: "Me_AvatarPlaceholder_75x75_"))
            nameLabel.text = user?.nickname
            contentLabel.text = comment?.content
        }
    }
    private func setupUI() {
        contentView.addSubview(imgView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(contentLabel)
        
        imgView.snp_makeConstraints { (make) in
            make.left.equalTo(contentView).offset(15)
            make.top.equalTo(contentView).offset(10)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        nameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(imgView.snp_right).offset(10)
            make.top.equalTo(imgView)
        }
        timeLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(nameLabel)
            make.right.equalTo(contentView).offset(-15)
        }
        contentLabel.snp_makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp_bottom).offset(10)
        }
    }
    
    private lazy var imgView: UIImageView = {
        let imgV = UIImageView()
        imgV.layer.cornerRadius = 15
        imgV.layer.masksToBounds = true
        imgV.userInteractionEnabled = true
        imgV.backgroundColor = UIColor.lightGrayColor()
        return imgV
    }()
    
    private lazy var nameLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGrayColor()
        label.font = UIFont.systemFontOfSize(13)
//        label.text = "萨科技大八岁"
        return label
    }()

    private lazy var timeLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGrayColor()
        label.font = UIFont.systemFontOfSize(12)
        label.text = "12-29 19:08"
        return label
    }()

    private lazy var contentLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGrayColor()
        label.font = UIFont.systemFontOfSize(14)
//        label.text = "有谁买多，评价一下"
        return label
    }()

}
