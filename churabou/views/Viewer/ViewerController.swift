//
//  ViewerController.swift
//  churabou
//
//  Created by ちゅーたつ on 2018/04/01.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import UIKit
import AVFoundation

class ViewerController: UIViewController {

    fileprivate var selectedIndex = 0
    
    func set(index: Int) {
        selectedIndex = index
    }
    
    fileprivate var viewModel = ImageModel()
   
    func bind(viewModel: ImageModel) {
        self.viewModel = viewModel
    }
    
    fileprivate var timer: Timer?
    fileprivate var audioPlayer: AVAudioPlayer?
    fileprivate var bottomView = BottomView()
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        v.dataSource = self
        v.delegate = self
        v.backgroundColor = .white
        v.scrollIndicatorInsets = .zero
        v.register(CollectionCell.self, forCellWithReuseIdentifier: "cell")
        v.isPagingEnabled = true
        return v
    }()

    override func viewDidLoad() {
        view.addSubview(collectionView)
        bottomView.setUp()
        bottomView.delegate = self
        view.addSubview(bottomView)
        collectionView.performBatchUpdates(nil, completion: { finished in
            self.scroll(to: self.selectedIndex)
        })
    }
    
    override func viewWillLayoutSubviews() {
        
        collectionView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(-70)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(70)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        audioPlayer?.stop()
    }
    
    func scroll(to: Int, animated: Bool = false) {
        collectionView.contentOffset.x = CGFloat(to) * collectionView.bounds.width
    }
    
    @objc fileprivate func actionTimer() {
     
        let currentIndex = Int(collectionView.contentOffset.x / collectionView.bounds.width)
        if currentIndex == viewModel.model$.value.count-1 {
            collectionView.contentOffset.x = 0
        }
        let x = collectionView.bounds.width
        collectionView.contentOffset.x += x
    }

    fileprivate var currentIndex: Int {
        return Int(collectionView.contentOffset.x / collectionView.bounds.width)
    }
}

extension ViewerController: BottomViewDelegate {
    
    func didSelectBack() {

        if currentIndex == 0 {
            return
        }
        collectionView.contentOffset.x -=  collectionView.bounds.width

//        UIView.animate(withDuration: 0.3, animations: {
//            self.collectionView.contentOffset.x -= x
//        })
    }
    
    func didSelectNext() {
        
        if currentIndex == viewModel.model$.value.count-1 {
            return
        }
        collectionView.contentOffset.x += collectionView.bounds.width
//        UIView.animate(withDuration: 0.3, animations: {
//            self.collectionView.contentOffset.x += x
//        })
    }
    
    func didSelectPlay(_ isPlaying: Bool) {
        
        if isPlaying {
            timer?.invalidate()
            audioPlayer?.stop()
        } else {
            guard let path = Bundle.main.path(forResource: "koinu", ofType: "mp3") else {
                return
            }
            let audioUrl = URL(fileURLWithPath: path)
            audioPlayer = try? AVAudioPlayer(contentsOf: audioUrl)
            audioPlayer?.play()
            
            timer = Timer.scheduledTimer(timeInterval: 0.5,
                                         target: self,
                                         selector: #selector(actionTimer),
                                         userInfo: nil,
                                         repeats: true)
        }
    }
}


extension ViewerController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let w = UIScreen.main.bounds.width-10
        return CGSize(width: w, height: w)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}

extension ViewerController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.model$.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionCell else {
            return UICollectionViewCell()
        }

        cell.loadImage(url: viewModel.model$.value[indexPath.row])
        return cell
    }
}


