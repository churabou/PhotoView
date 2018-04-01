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
        layout.scrollDirection = .vertical
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        v.dataSource = self
        v.delegate = self
        v.alwaysBounceVertical = true
        v.scrollIndicatorInsets = .zero
        v.backgroundColor = .white
        v.register(CollectionCell.self, forCellWithReuseIdentifier: "cell")
        return v
    }()
    
    fileprivate var viewModel = ViewModel()
    fileprivate var slider = SliderView()
    fileprivate var viewer = ViewerController()
    fileprivate var disPlayNum = 4
    
    override func viewDidLoad() {
        view.addSubview(collectionView)
        slider.setUp()
        slider.delegate = self
        view.addSubview(slider)
    }
    
    func setVM(_ viewModel: ViewModel) {
        self.viewModel = viewModel
        viewer.bind(viewModel: viewModel)
    }
    
    override func viewWillLayoutSubviews() {

        collectionView.snp.remakeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(-70)
        }
        
        
        slider.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(70)
        }
    }
}

extension CategoryDetailViewController: SliderViewDelegate {
    func didValueChanged(_ value: Int) {
        disPlayNum = value
        collectionView.reloadData()
    }
}

extension CategoryDetailViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Sketchのレイアウト比率に合わせる / w320px: 140x190

        let s = view.bounds.width/CGFloat(disPlayNum)
        return CGSize(width: s-1, height: s-1)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension CategoryDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(viewer, animated: true)
    }
}




