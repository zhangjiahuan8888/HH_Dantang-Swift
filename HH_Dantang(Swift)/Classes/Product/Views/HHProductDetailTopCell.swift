//
//  HHProductDetailTopCell.swift
//  HH_Dantang(Swift)
//
//  Created by 张家欢 on 16/8/18.
//  Copyright © 2016年 zhangjiahuan. All rights reserved.
//

import UIKit

class HHProductDetailTopCell: UITableViewCell {

    var bannerView : HHScrollView?
    var product: HHProductModel? {
        didSet {
            bannerView!.setDataSource(product!.image_urls)
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
        
        bannerView = HHScrollView(frame: CGRectMake(0, 0, KSCREENWIDTH, 300))
        bannerView!.backgroundColor = UIColor.cyanColor()
        contentView.addSubview(bannerView!)
        
        contentView.addSubview(titleLabel)
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(-15)
            make.top.equalTo(bannerView!.snp_bottom).offset(10)
        }
        
        contentView.addSubview(priceLabel)
        priceLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(-15)
            make.top.equalTo(titleLabel.snp_bottom).offset(10)
        }
        
        contentView.addSubview(describeLabel)
        describeLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(-15)
            make.top.equalTo(priceLabel.snp_bottom).offset(10)
        }
    }
    
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
