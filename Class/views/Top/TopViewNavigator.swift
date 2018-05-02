//
//  TopViewNavigator.swift
//  churabou
//
//  Created by ちゅーたつ on 2018/05/02.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import UIKit


class TopViewNavigator {
    
    enum Direction {
        case detail(model: ImageModel), viewer(model: ImageModel, index: Int)
    }
    
    private var controller: UIViewController
    
    init(_ controller: UIViewController) {
        self.controller = controller
    }
    

    func navigate(to: Direction) {
        let next = createController(to: to)
        controller.navigationController?.pushViewController(next, animated: true)
    }
    
    func createController(to: Direction) -> UIViewController {
        
        switch to {
        case .detail(let model):
            let v = CategoryDetailViewController()
            v.update(model)
            return v
        case .viewer(let model, let index):
            let v = ViewerController()
            v.bind(viewModel: model)
            v.set(index: index)
            return v
        }
    }
}
