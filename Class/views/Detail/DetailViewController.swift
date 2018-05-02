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
    
    fileprivate var viewModel = ImageModel()
    fileprivate var slider = SliderView()
    fileprivate var disPlayNum = 3
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        slider.delegate = self
        view.addSubview(slider)
    }

    func update(_ viewModel: ImageModel) {
        self.viewModel = viewModel
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

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

        let s = view.bounds.width/CGFloat(disPlayNum)
        return CGSize(width: s, height: s)
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

        cell.loadImage(url: viewModel.model$.value[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let v = ViewerController()
        v.bind(viewModel: viewModel)
        v.set(index: indexPath.row)
        navigationController?.pushViewController(v, animated: true)
    }
}

extension CategoryDetailViewController: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if velocity.y > 0 {
            slider.hide(animated: true)
        } else {
            slider.show(animated: true)
        }
    }
}






