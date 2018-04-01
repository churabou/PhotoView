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
    var makeCircle = false
   
    func setUp() {
        backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        contentView.addSubview(imageView)
    }

    override func draw(_ rect: CGRect) {
        
        if makeCircle {
            contentView.backgroundColor = .white
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = imageView.frame.height/2
            imageView.clipsToBounds = true
        }
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
