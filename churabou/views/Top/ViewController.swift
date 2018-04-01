//
//  ViewController.swift
//  churabou
//
//  Created by ちゅーたつ on 2018/03/31.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let targets: [ViewModel] = [
        ViewModel("ラーメン","capital_noodle"),
        ViewModel("パンケーキ","pancake__suki"),
        ViewModel("カレルチャペック", "karelabuzzy")
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView) 
        //おそらくリクエスト中にsubscribeしている。
        DispatchQueue.global().async {
            print("リクエスト")
            self.targets.forEach { $0.fetch() }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {

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
        cell.setUp(targets[indexPath.row])
        cell.indexPath = indexPath
        return cell
    }
}

extension ViewController: CategoryTableViewCellDelegate {
  
    func didSelectAll(_ indexPath: IndexPath) {
        let v = CategoryDetailViewController()
        v.setVM(targets[indexPath.row])
        navigationController?.pushViewController(v, animated: true)
    }
    
    func didSelectImage(_ v: UIViewController) {
         navigationController?.pushViewController(v, animated: true)
    }
}
