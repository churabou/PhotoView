//
//  ViewModel.swift
//  churabou
//
//  Created by ちゅーたつ on 2018/04/01.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import Foundation


class ViewModel {
    var models: [String] = [] {
        didSet {
            modelDidSet()
        }
    }
    
    var modelDidSet = {}
    
    func fetch() {
        getTimeLine(completion: { urls in
            self.models = urls
        })
    }
}
