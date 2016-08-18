//
//  HHProductCell.swift
//  HH_Dantang(Swift)
//
//  Created by 张家欢 on 16/8/5.
//  Copyright © 2016年 zhangjiahuan. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class HHProductCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.backgroundColor = UIColor.whiteColor()
        contentView.layer.cornerRadius = 3
        contentView.layer.masksToBounds = true
        contentView.layer.borderColor = UIColor.lightGrayColor().CGColor
        contentView.layer.borderWidth = 0.3
        
        contentView.addSubview(picView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)

        picView.snp_makeConstraints { (make) in
            make.left.equalTo(contentView)
            make.top.equalTo(contentView)
            make.right.equalTo(contentView)
            make.height.equalTo((UIScreen.mainScreen().bounds.width - 30) / 2)
        }
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(contentView).offset(5)
            make.right.equalTo(contentView).offset(-5)
            make.top.equalTo(picView.snp_bottom).offset(5)
        }
        priceLabel.snp_makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.bottom.equalTo(contentView).offset(-3)
        }
    }
    
    var product: HHProductModel? {
        didSet {
            let url = product?.cover_image_url
            picView.kf_setImageWithURL(NSURL(string: url!)!)
            titleLabel.text = product?.name
            priceLabel.text = "¥" + (product?.price)!
        }
        
    }
    
    // MARK: - 懒加载
    private lazy var picView = UIImageView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
//        label.text = "可爱大白多肉植物组合盆栽";
        label.font = UIFont.systemFontOfSize(15)
        label.numberOfLines = 2
        label.textColor = UIColor.grayColor()
        return label
    }()
    
    private lazy var priceLabel:UILabel = {
        let label = UILabel()
//        label.text = "¥ 89.00";
        label.textColor = HHGlobalRedColor()
        label.font = UIFont.systemFontOfSize(14)
        return label
    }()
}
