//
//  ViewModel.swift
//  churabou
//
//  Created by ちゅーたつ on 2018/04/01.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import Foundation


class ViewModel {
    
    var target = "pancake__suki"

    var models: [String] = [] {
        didSet {
            modelDidSet()
        }
    }
    
    var modelDidSet = {}
    
    func fetch() {
        getImage(of: target, completion: { urls in
            self.models = urls
        })
    }
}
