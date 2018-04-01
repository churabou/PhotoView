//
//  PhotoViewerController.swift
//  churabou
//
//  Created by ちゅーたつ on 2018/03/31.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import SnapKit

fileprivate final class TopView: UIView {
    
    fileprivate var closeButton = UIButton()
    
    func setUp() {
        backgroundColor = .blue
        closeButton.setTitle("close", for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        addSubview(closeButton)
    }
    
    override func layoutSubviews() {
        closeButton.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.top.left.equalTo(5)
        }
    }
}



fileprivate final class BottomView: UIView {
    
    fileprivate var playButton = UIButton()
    
    func setUp() {
        backgroundColor = .blue
        playButton.setTitle("play", for: .normal)
        playButton.setTitleColor(.white, for: .normal)
        addSubview(playButton)
    }
    
    override func layoutSubviews() {
        playButton.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.center.equalToSuperview()
        }
    }
}



class PhotoViewer: UIView {
    
    fileprivate var topView = TopView()
    fileprivate var bottomView = BottomView()

    func setUp() {
        topView.setUp()
        addSubview(topView)
        bottomView.setUp()
        addSubview(bottomView)
    }
    
    override func layoutSubviews() {
        topView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
    }
}
