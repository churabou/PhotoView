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
    
    fileprivate var viewModel = ViewModel()

    func share(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        v.dataSource = self
        v.delegate = self
        v.alwaysBounceVertical = true
        v.scrollIndicatorInsets = .zero
        v.register(CollectionCell.self, forCellWithReuseIdentifier: "cell")
//        v.isPagingEnabled = true
        return v
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .black
        view.addSubview(collectionView)
    play()
    }

    override func viewWillLayoutSubviews() {
        
        collectionView.snp.remakeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.height.equalTo(300)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        audioPlayer.stop()
    }
    
    var audioPlayer: AVAudioPlayer!
    
    func play() {
     
        guard let path = Bundle.main.path(forResource: "koinu", ofType: "mp3") else {
            return
        }
        let audioUrl = URL(fileURLWithPath: path)
        audioPlayer = try! AVAudioPlayer(contentsOf: audioUrl)
        audioPlayer.play()
        
//        let t = Double(viewModel.models.count)
//        UIView.animate(withDuration: t, animations: {
//            self.collectionView.contentOffset.x = 100
//        })
    }
    
    
}

extension ViewerController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Sketchのレイアウト比率に合わせる / w320px: 140x190
        
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
        cell.setUp()
        cell.loadImage(url: viewModel.model$.value[indexPath.row])
        return cell
    }
}


