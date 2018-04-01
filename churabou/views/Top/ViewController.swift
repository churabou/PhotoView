//
//  ViewController.swift
//  churabou
//
//  Created by ちゅーたつ on 2018/03/31.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    let targets: [(String, String)] = [
        ("ラーメン","capital_noodle"),
        ("パンケーキ","pancake__suki"),
        ("カレルチャペック", "karelabuzzy")
    ]

    fileprivate lazy var tableView: UITableView = {
        let t = UITableView()
        t.frame = view.frame
        t.register(CategoryTableViewCell.self, forCellReuseIdentifier: "cell")
        t.dataSource = self
        t.delegate = self
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        view.addSubview(tableView)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CategoryTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {            
        let v = CategoryDetailViewController()
        v.setVM(target: targets[indexPath.row].1)
        navigationController?.pushViewController(v, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return targets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CategoryTableViewCell else {
            return UITableViewCell()
        }
        cell.setUp(name: targets[indexPath.row].0)
        return cell
    }
}

