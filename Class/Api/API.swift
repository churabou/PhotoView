//
//  API.swift
//  churabou
//
//  Created by ちゅーたつ on 2018/03/31.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import Foundation
import Alamofire



struct Constants {
    
    static let key = ""
    static let secret = ""
    static let token = ""
    
    static var credential: String {
        return "\(key):\(secret)".data(using: .utf8)!.base64EncodedString()
    }
}

struct Api {
    
    static func getBearerToken() {
        
        let url = "https://api.twitter.com/oauth2/token"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.httpBody = "grant_type=client_credentials".data(using: .utf8)
        let headers =  [
            "Authorization": "Basic \(Constants.credential)",
            "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8"
        ]
        headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key)}
        
        Alamofire.request(request).responseJSON {
            debugPrint($0)
        }
        
    }
    
    static func getImage(of: String, completion: @escaping (([String]) -> Swift.Void)) {
        
        let url = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=\(of)"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        //    request.httpBody = "user_id=@churabou1".data(using: .utf8)
        let headers =  [
            "Authorization": "Bearer \(Constants.token)",
            "Accept-Encoding": "gzip"
        ]
        headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                fatalError("aaaa")
            }
            
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
                print(response.allHeaderFields)
            }
    
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
//                let models = try JSONDecoder().decode([Model].self, from: data)
//                debugPrint(models)
                let urls = Timeline.fetchImages(json: json)
                DispatchQueue.main.async {
                     completion(urls)
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    
    }
    
    struct Model: Codable {
        
        let text: String
        let created_at: String
        let entities: Entity
        
            struct Entity: Codable {
                let media: [Media]
                
                struct Media: Codable {
                    var id: String
                    var media_url: String
                }
            }

    }
    static func search(q: String) {
        
        let url = "https://api.twitter.com/1.1/search/tweets.json?q=\(q)"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        //    request.httpBody = "q=japan".data(using: .utf8)
        let headers =  [
            "Authorization": "Bearer \(Constants.token)"
        ]
        headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        Alamofire.request(request).responseData { (response) in

            let t = Timeline.decode(data: response.data!)
            debugPrint(t)
        }
    }
}
