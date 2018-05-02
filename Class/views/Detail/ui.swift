//
//  PhotoViewerController.swift
//  churabou
//
//  Created by ちゅーたつ on 2018/03/31.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import SnapKit


protocol BottomViewDelegate: class {
    func didSelectPlay(_ isPlaying: Bool)
    func didSelectNext()
    func didSelectBack()
}

final class BottomView: BaseView {
    
    weak var delegate: BottomViewDelegate?
    fileprivate var playButton = UIButton()
    fileprivate var nextButton = UIButton()
    fileprivate var backButton = UIButton()
    
    override func initializeView() {
        
        backgroundColor = .pink

        playButton.setTitle("play", for: .normal)
        playButton.setTitleColor(.white, for: .normal)
        playButton.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        addSubview(playButton)
        
        nextButton.setTitle("next", for: .normal)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.addTarget(self, action: #selector(actionNext), for: .touchUpInside)
        addSubview(nextButton)
        
        backButton.setTitle("back", for: .normal)
        backButton.setTitleColor(.white, for: .normal)
        backButton.addTarget(self, action: #selector(actionBack), for: .touchUpInside)
        addSubview(backButton)
    }
    
    override func initializeConstraints() {
        
        playButton.snp.makeConstraints { (make) in
            make.width.equalToSuperview().dividedBy(3)
            make.center.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { (make) in
            make.width.equalToSuperview().dividedBy(3)
            make.top.right.bottom.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { (make) in
            make.width.equalToSuperview().dividedBy(3)
            make.top.left.bottom.equalToSuperview()
        }
    }
    
    @objc private func actionButton() {
        delegate?.didSelectPlay(isPlaying)
        isPlaying = !isPlaying
    }
    
    @objc private func actionNext() {
        delegate?.didSelectNext()
    }
    
    @objc private func actionBack() {
        delegate?.didSelectBack()
    }
    
    fileprivate var isPlaying = false {
        didSet {
            if isPlaying {
                playButton.setTitle("stop", for: .normal)
                nextButton.isHidden = true
                backButton.isHidden = true
            } else {
                playButton.setTitle("play", for: .normal)
                nextButton.isHidden = false
                backButton.isHidden = false
            }
        }
    }
}

protocol SliderViewDelegate: class {
    func didValueChanged(_ value: Int)
}

final class SliderView: BaseView {
    
    weak var delegate: SliderViewDelegate?
    fileprivate var slider = UISlider()
    
    override func initializeView() {

        backgroundColor = .pink
        slider.minimumValue = 1
        slider.maximumValue = 7
        slider.value = 4
        slider.addTarget(self, action: #selector(actionSlider), for: .valueChanged)
        addSubview(slider)
    }
    
    override func initializeConstraints() {

        slider.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(50)
            make.right.equalTo(-50)
        }
    }

    fileprivate var value: Int = 4 {
        didSet {
            if oldValue != value {
                delegate?.didValueChanged(value)
            }
        }
    }

    @objc private func actionSlider(_ sender: UISlider) {
        value = Int(round(sender.value))
    }
    
    fileprivate var isShowing = false
    func hide(animated: Bool) {
        
        if animated {
            UIView.animate(withDuration: 0.2, animations: {
                self.alpha = 0
            }, completion: { _ in
                self.isHidden = true
            })
        } else {
            alpha = 0
             isHidden = true
        }
        isShowing = false
    }
    
    func show(animated: Bool) {
        self.isHidden = false
        if animated {
            UIView.animate(withDuration: 0.2, animations: {
                 self.alpha = 1
            })
        } else {
            alpha = 1
        }
        isShowing = true
    }
    
    func animate() {
        if isShowing {
            hide(animated: true)
        } else {
            show(animated: true)
        }
    }
}





