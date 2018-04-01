//
//  CategoryTableViewCell.swift
//  churabou
//
//  Created by ちゅーたつ on 2018/03/31.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import SnapKit
import Kingfisher
import RxSwift

class CategoryTableViewCell: UITableViewCell {
    
    static var height: CGFloat {
        return (UIScreen.main.bounds.width/2 + 55)
    }
    
    fileprivate var model = ViewModel()
    fileprivate lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 18)
        l.textColor = .gray
        l.text = "ラーメン"
        return l
    }()
    
    fileprivate lazy var showButton: UIButton = {
        let b = UIButton()
        b.setTitle("全て見る", for: .normal)
        b.setTitleColor(.red, for: .normal)
        return b
    }()

    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        v.backgroundColor = .green
        v.dataSource = self
        v.delegate = self
        v.scrollIndicatorInsets = .zero
        v.register(CollectionCell.self, forCellWithReuseIdentifier: "cell")
        return v
    }()
    
    private let bag = DisposeBag()
    func setUp(_ viewModel: ViewModel) {
        model = viewModel
        model.model$.asObservable().subscribe(onNext: { _ in
            self.collectionView.reloadData()
        }).disposed(by: bag)
        nameLabel.text = model.name
        addSubview(nameLabel)
        addSubview(showButton)
        addSubview(collectionView)
    }
    
    
    override func layoutSubviews() {
       
        nameLabel.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.height.equalTo(30)
            make.top.left.equalTo(10)
        }
        
        showButton.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.height.equalTo(30)
            make.top.equalTo(10)
            make.right.equalTo(-10)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(-5)
        }
    }    
}




extension CategoryTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Sketchのレイアウト比率に合わせる / w320px: 140x190
        
        let s = bounds.width/2
        return CGSize(width: s-10, height: s-10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
}

extension CategoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.model$.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionCell else {
            return UICollectionViewCell()
        }
        
        cell.setUp()
        cell.loadImage(url: model.model$.value[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}


