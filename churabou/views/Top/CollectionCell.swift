//
//  CollectionCell.swift
//  churabou
//
//  Created by ちゅーたつ on 2018/04/01.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import SnapKit
import Kingfisher

class CollectionCell: UICollectionViewCell {
    
    fileprivate var imageView = UIImageView()
   
    func setUp() {
        contentView.addSubview(imageView)
    }
    
    override func layoutSubviews() {
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func loadImage(url: String) {
        imageView.kf.setImage(with: URL(string: url))
    }
}
