//
//  PhotoViewerController.swift
//  churabou
//
//  Created by ちゅーたつ on 2018/03/31.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import SnapKit


final class BottomView: UIView {
    
    fileprivate var playButton = UIButton()
    
    func setUp() {
        backgroundColor = .blue
        playButton.setTitle("play", for: .normal)
        playButton.setTitleColor(.white, for: .normal)
        playButton.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        addSubview(playButton)
    }
    
    override func layoutSubviews() {
        playButton.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.center.equalToSuperview()
        }
    }
    
    
    var tapClosure = {}

    @objc private func actionButton() {
        tapClosure()
    }
}


extension UIColor {
    class var pink: UIColor {
        return UIColor(red: 1, green: 192/255, blue: 203/255, alpha: 1)
    }
}

protocol SliderViewDelegate: class {
    func didValueChanged(_ value: Int)
}

final class SliderView: UIView {
    
    weak var delegate: SliderViewDelegate?
    fileprivate var slider = UISlider()
    
    func setUp() {
        backgroundColor = .pink
        slider.minimumValue = 1
        slider.maximumValue = 7
        slider.value = 4
        slider.addTarget(self, action: #selector(actionSlider), for: .valueChanged)
        addSubview(slider)
    }
    
    override func layoutSubviews() {
        slider.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(50)
            make.right.equalTo(-50)
        }
    }

    @objc private func actionSlider(_ sender: UISlider) {
        delegate?.didValueChanged(Int(sender.value))
    }
}





