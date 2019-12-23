//
//  HeroViewModel.swift
//  MarvelHerosMVVM
//
//  Created by Marcio Brufatto on 20/12/19.
//  Copyright © 2019 Marcio Brufatto. All rights reserved.
//

import Foundation

class HeroViewModel {
    
    private var heroes: [Hero] = []
    
    func numberOfRows(_ section: Int) -> Int {
        return self.heroes.count
    }
    
    func heroAt(_ index: Int) -> Hero {
        return self.heroes[index]
    }

    func loadCharacters(completion: @escaping([Hero]) ->()) {
        let heroesUrl = "https://gateway.marvel.com/v1/public/characters"
        let heroesResource = Resource<HeroBase>(url: heroesUrl) { data in
            let heroData = try? JSONDecoder().decode(HeroBase.self, from: data)
            return heroData
        }

        NetworkingManager().load(resource: heroesResource) { result in

            if let heroData = result {
                self.heroes = heroData.data.results
                completion(self.heroes)
            } else {
                completion([Hero]())
            }
            
        }
    }
}
