//
//  ViewController.swift
//  churabou
//
//  Created by ちゅーたつ on 2018/03/31.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {
    
    let targets: [ImageModel] = [
        ImageModel("子犬・子猫", "dogs_cats_bot"),
        ImageModel("ラーメン","capital_noodle"),
        ImageModel("パンケーキ","pancake__suki"),
        ImageModel("ポケモン","p0kemoncute")
    ]

    fileprivate lazy var tableView: UITableView = {
        let t = UITableView()
        t.frame = view.frame
        t.register(CategoryTableViewCell.self, forCellReuseIdentifier: "cell")
        t.dataSource = self
        t.delegate = self
        t.allowsSelection = false
        return t
    }()
    
    private var navigator: TopViewNavigator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        navigator = TopViewNavigator(self)
        //おそらくリクエスト中にsubscribeしている。
        DispatchQueue.global().async {
            self.targets.forEach { $0.fetch() }
        }
    }
}

extension TopViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CategoryTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return targets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CategoryTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.update(targets[indexPath.row])
        return cell
    }
}

extension TopViewController: CategoryTableViewCellDelegate {
    func didSelectAll(model: ImageModel) {
        navigator?.navigate(to: .detail(model: model))
    }
    
    func didSelectImage(at: Int, model: ImageModel) {
        navigator?.navigate(to: .viewer(model: model, index: at))
    }
}
