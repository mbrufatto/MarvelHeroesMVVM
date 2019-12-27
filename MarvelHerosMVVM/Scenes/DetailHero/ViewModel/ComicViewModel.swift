//
//  ComicViewModel.swift
//  MarvelHerosMVVM
//
//  Created by Marcio Brufatto on 27/12/19.
//  Copyright © 2019 Marcio Brufatto. All rights reserved.
//

import Foundation

class ComicViewModel {
    
    private var comics: [Comic] = []
    
    func numberOfRows(_ section: Int) -> Int {
        return self.comics.count
    }
    
    func comicAt(_ index: Int) -> Comic {
        return self.comics[index]
    }
    
    func loadComics(heroId: Int, completion: @escaping([Comic]) ->()) {
        let heroesUrl = "https://gateway.marvel.com/v1/public/characters/\(heroId)/comics"
        
        let comicsResource = Resource<ComicBase>(url: heroesUrl, offset: 0) { data in
            let comicData = try? JSONDecoder().decode(ComicBase.self, from: data)
            return comicData
        }
        
        NetworkingManager().load(resource: comicsResource) { result in
            if let comicData = result {
                self.comics = comicData.data.results
                completion(self.comics)
            } else {
                completion([Comic]())
            }
            
        }
    }
    
}
