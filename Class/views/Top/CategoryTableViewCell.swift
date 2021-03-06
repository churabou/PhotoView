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


protocol CategoryTableViewCellDelegate: class {
    func didSelectAll(model: ImageModel)
    func didSelectImage(at: Int, model: ImageModel)
}

class CategoryTableViewCell: BaseTableViewCell {
    
    static var height: CGFloat {
        return (UIScreen.main.bounds.width/2 + 55)
    }
    
    weak var delegate: CategoryTableViewCellDelegate?
    fileprivate var model = ImageModel()
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
        b.backgroundColor = .pink
        b.setTitleColor(.white, for: .normal)
        b.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        return b
    }()

    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        v.dataSource = self
        v.delegate = self
        v.scrollIndicatorInsets = .zero
        v.backgroundColor = .white
        v.register(CollectionCell.self, forCellWithReuseIdentifier: "cell")
        return v
    }()
    
    private let bag = DisposeBag()
    func update(_ viewModel: ImageModel) {
        model = viewModel
        model.model$.asObservable().subscribe(onNext: { _ in
            self.collectionView.reloadData()
        }).disposed(by: bag)
        nameLabel.text = model.name
    }

    override func initializeView() {
        addSubview(nameLabel)
        addSubview(showButton)
        addSubview(collectionView)
    }
    
    override func initializeConstraints() {

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

    @objc private func actionButton() {
        delegate?.didSelectAll(model: model)
    }
}




extension CategoryTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
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
        
        cell.makeCircle()
        cell.loadImage(url: model.model$.value[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectImage(at: indexPath.row, model: model)
    }
}
