//
//  Hero.swift
//  MarvelHerosMVVM
//
//  Created by Marcio Brufatto on 20/12/19.
//  Copyright © 2019 Marcio Brufatto. All rights reserved.
//

import Foundation

struct Hero: Decodable {

    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail
}

struct HeroData: Decodable {
    
    let results: [Hero]
    let total: Int
}

struct HeroBase: Decodable {
    
    let data: HeroData
    let status: String
}
