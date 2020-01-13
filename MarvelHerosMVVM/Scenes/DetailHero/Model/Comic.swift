//
//  Comic.swift
//  MarvelHerosMVVM
//
//  Created by Marcio Brufatto on 26/12/19.
//  Copyright © 2019 Marcio Brufatto. All rights reserved.
//

import Foundation


struct Comic: Decodable {
    let title: String
    let thumbnail: Thumbnail
}

struct ComicData: Decodable {
    let results: [Comic]
    let total: Int
}

struct ComicBase: Decodable {
    let data: ComicData
}
