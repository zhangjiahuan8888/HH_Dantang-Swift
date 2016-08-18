//
//  HHProductController.swift
//  HH_Dantang(Swift)
//
//  Created by 张家欢 on 16/8/5.
//  Copyright © 2016年 zhangjiahuan. All rights reserved.
//

import UIKit

class HHProductController: HHBaseViewController {

    var products = [HHProductModel]()
    weak var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        
        weak var weakSelf = self
        HHNetWorkTool.shareNetworkTool.loadProductData { (products) in
            weakSelf?.products = products
            print("----------\(products)")
            weakSelf?.collectionView?.reloadData()
        }
    }

    private func setupCollectionView(){
        let layout = UICollectionViewFlowLayout()
        let dantangCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        dantangCollectionView.dataSource = self
        dantangCollectionView.delegate = self
        dantangCollectionView.backgroundColor = view.backgroundColor
        dantangCollectionView.registerClass(HHProductCell.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(dantangCollectionView)
        self.collectionView = dantangCollectionView
    }

}
extension HHProductController:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! HHProductCell
        cell.product = products[indexPath.item]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width: CGFloat = (UIScreen.mainScreen().bounds.width - 30) / 2
        let height: CGFloat = 210
        return CGSizeMake(width, height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        let productDetailVC = HHProductDetailViewController()
        navigationController?.pushViewController(productDetailVC, animated: true)
    }
}