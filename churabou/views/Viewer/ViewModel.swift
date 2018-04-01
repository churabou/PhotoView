//
//  ViewModel.swift
//  churabou
//
//  Created by ちゅーたつ on 2018/04/01.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import Foundation
import RxSwift

class ViewModel {
    
    var name = ""
    var target = ""
    
    convenience init(_ name: String, _ target: String) {
        self.init()
        self.name = name
        self.target = target
    }

    var model$: Variable<[String]> = Variable([])

    func fetch() {
        getImage(of: target, completion: { urls in
            self.model$.value = urls
        })
    }
}
