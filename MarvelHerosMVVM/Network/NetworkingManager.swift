//
//  NetworkingManager.swift
//  MarvelHerosMVVM
//
//  Created by Marcio Brufatto on 20/12/19.
//  Copyright © 2019 Marcio Brufatto. All rights reserved.
//

import Foundation
import CryptoSwift

struct Resource<T> {
    let url: String
    let offset: Int
    let heroName: String?
    let parse: (Data) -> T?
}

fileprivate struct MarvelAPIConfig {
    static let privatekey = "d61ab35cbcbaa4d0be7aedd3d890589ee1bb2539"
    static let apikey = "08baf6764f4d353b904bdd472cbd7347"
    static let ts = Date().timeIntervalSince1970.description
    static let hash = "\(ts)\(privatekey)\(apikey)".md5()
}

final class NetworkingManager {
    
    func load<T>(resource: Resource<T>, completion: @escaping(T?) -> ()) {
        
        var charactersURL = URLComponents(string: resource.url)!
        charactersURL.queryItems = [URLQueryItem(name: "apikey", value: MarvelAPIConfig.apikey),
                                    URLQueryItem(name: "ts", value: MarvelAPIConfig.ts),
                                      URLQueryItem(name: "hash", value: MarvelAPIConfig.hash)]
        
        if resource.heroName != nil {
            charactersURL.queryItems?.append(URLQueryItem(name: "nameStartsWith", value:resource.heroName))
        } else {
            charactersURL.queryItems?.append(URLQueryItem(name: "offset", value: "\(resource.offset)"))
        }
        
        let finalURL = charactersURL.url
        var request = URLRequest(url: finalURL!)
        
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    completion(resource.parse(data))
                }
            } else {
                completion(nil)
            }
        }.resume()
    }
    
    private func securePath(path:String) -> String {
        if path.hasPrefix("http://") {
            let range = path.range(of: "http://")
            var newPath = path
            newPath.removeSubrange(range!)
            return "https://" + newPath
        } else {
            return path
        }
    }
}
