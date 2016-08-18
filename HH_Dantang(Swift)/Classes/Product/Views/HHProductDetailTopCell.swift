//
//  HHProductDetailTopCell.swift
//  HH_Dantang(Swift)
//
//  Created by 张家欢 on 16/8/18.
//  Copyright © 2016年 zhangjiahuan. All rights reserved.
//

import UIKit

class HHProductDetailTopCell: UITableViewCell {

    var product: HHProductModel? {
        didSet {

            titleLabel.text = product?.name
            priceLabel.text = "¥\(product!.price! as String)"
            describeLabel.text = product?.describe
        }
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(){
        self.backgroundColor = UIColor.whiteColor()
        contentView.addSubview(imgView)
        imgView.snp_makeConstraints { (make) in
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
            make.top.equalTo(contentView)
            make.height.equalTo(300)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(imgView).offset(15)
            make.right.equalTo(imgView).offset(-15)
            make.top.equalTo(imgView.snp_bottom).offset(10)
        }
        
        contentView.addSubview(priceLabel)
        priceLabel.snp_makeConstraints { (make) in
            make.left.equalTo(imgView).offset(15)
            make.right.equalTo(imgView).offset(-15)
            make.top.equalTo(titleLabel.snp_bottom).offset(10)
        }
        
        contentView.addSubview(describeLabel)
        describeLabel.snp_makeConstraints { (make) in
            make.left.equalTo(imgView).offset(15)
            make.right.equalTo(imgView).offset(-15)
            make.top.equalTo(priceLabel.snp_bottom).offset(10)
        }
    }
    
    private lazy var imgView: UIImageView = {
        let imgV = UIImageView()
        imgV.backgroundColor = UIColor.redColor()
        imgV.userInteractionEnabled = true
        return imgV
    }()
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGrayColor()
        label.font = UIFont.systemFontOfSize(18)
        return label
    }()

    private lazy var priceLabel:UILabel = {
        let label = UILabel()
        label.textColor = HHGlobalRedColor()
        label.font = UIFont.systemFontOfSize(16)
        return label
    }()

    private lazy var describeLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGrayColor()
        label.font = UIFont.systemFontOfSize(15)
        label.numberOfLines = 2
        return label
    }()

}
