//
//  ViewerController.swift
//  churabou
//
//  Created by ちゅーたつ on 2018/04/01.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import UIKit

class ViewerController: UIViewController {
    
    fileprivate var viewModel = ViewModel()

    func share(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        v.backgroundColor = .green
        v.dataSource = self
        v.delegate = self
        v.alwaysBounceVertical = true
        v.scrollIndicatorInsets = .zero
        v.register(CollectionCell.self, forCellWithReuseIdentifier: "cell")
        v.isPagingEnabled = true
        return v
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .black
        view.addSubview(collectionView)
    }

    override func viewWillLayoutSubviews() {
        
        collectionView.snp.remakeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.height.equalTo(300)
        }
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
        return viewModel.models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionCell else {
            return UICollectionViewCell()
        }
        cell.setUp()
        cell.loadImage(url: viewModel.models[indexPath.row])
        return cell
    }
}



