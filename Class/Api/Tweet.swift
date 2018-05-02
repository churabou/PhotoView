//
//  Tweet.swift
//  churabou
//
//  Created by ちゅーたつ on 2018/04/01.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Timeline: Codable {
    
    let statuses: [Tweet]
    
    struct Tweet: Codable {
        
        let text: String
        let created_at: String
//        let entities: Entity
    }
    
    struct Entity: Codable {
        let media: [Media]
    }
    
    struct Media: Codable {
        let media_url: String
    }
    
    static func decode(data: Data) -> [Tweet] {
        let decoder = JSONDecoder()
        return try! decoder.decode(Timeline.self, from: data).statuses
    }
}

extension Timeline {

    static func fetchImages(json: Any) -> [String] {
        
        return JSON(json)
            .arrayValue
            .compactMap { $0["entities"]["media"][0]["media_url_https"].string}
        }
}


struct Tweet: Codable {
    
    let text: String
    let created_at: String
//    let entities: Any
//
//    struct Entity: Codable {
//        let media: [Media]
//    }
//
//    struct Media: Codable {
//        let media_url: String
//    }
}
