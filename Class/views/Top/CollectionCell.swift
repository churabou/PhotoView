//
//  CollectionCell.swift
//  churabou
//
//  Created by ちゅーたつ on 2018/04/01.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import SnapKit
import Kingfisher

class CollectionCell: BaseCollectionViewCell {
    
    fileprivate var imageView = UIImageView()
    fileprivate var isCircle = false
    
    func makeCircle() {
        isCircle = true
    }
   
    override func initializeView() {
        backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        contentView.addSubview(imageView)
    }

    override func draw(_ rect: CGRect) {
        
        if isCircle {
            contentView.backgroundColor = .white
//            imageView.contentMode = .center
            imageView.layer.cornerRadius = imageView.frame.height/2
            imageView.clipsToBounds = true
        }
    }

    override func initializeConstraints() {
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    func loadImage(url: String) {
        imageView.kf.setImage(with: URL(string: url), completionHandler: { img, _, _, _ in
            self.imageView.image = img?.cropThumbnailImage()
        })
    }
}
