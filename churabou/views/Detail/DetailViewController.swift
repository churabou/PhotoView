//
//  MealDetailViewController.swift
//  churabou
//
//  Created by ちゅーたつ on 2018/03/31.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import SnapKit

class CategoryDetailViewController: UIViewController {
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width/4, height: view.bounds.width/4)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        v.backgroundColor = .green
        v.dataSource = self
        v.delegate = self
        v.alwaysBounceVertical = true
        v.scrollIndicatorInsets = .zero
        v.register(CollectionCell.self, forCellWithReuseIdentifier: "cell")
        return v
    }()
    
    fileprivate var bottomView = BottomView()
    fileprivate var viewer = ViewerController()
    fileprivate var viewModel = ViewModel()
    
    override func viewDidLoad() {
        view.backgroundColor = .blue
        view.addSubview(collectionView)
        bottomView.setUp()
        bottomView.tapClosure = {
        }
        view.addSubview(bottomView)

    }
    
    func setVM(target: String) {
        viewModel.modelDidSet = {
            self.collectionView.reloadData()
        }
        viewModel.target = target
        viewer.share(viewModel: viewModel)
        viewModel.fetch()
    }
    override func viewWillLayoutSubviews() {

        collectionView.snp.remakeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(-70)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(70)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}



extension CategoryDetailViewController: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        // Sketchのレイアウト比率に合わせる / w320px: 140x190
//
//        let s = view.bounds.width/4
//        return CGSize(width: s-1, height: s-1)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
//    }
//
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension CategoryDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(viewer, animated: true)
    }
}




